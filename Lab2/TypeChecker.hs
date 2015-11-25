module TypeChecker where

import AbsCPP
import PrintCPP
import ErrM

import Control.Monad
import Data.Map (Map)
import qualified Data.Map as Map

type Environment      = (Functions, [Context])
type Functions      = Map Id ([Type], Type)
type Context  = Map Id Type

lookupFunction :: Environment -> Id -> Err ([Type], Type)
lookupFunction env fid =
  case Map.lookup fid (fst env) of
    Just funtyps  -> return funtyps
    Nothing       -> fail "Function name not declared"

updateFunction :: Environment -> Id -> ([Type], Type) -> Err Environment
updateFunction (functions, ctxs) f funtyps =
  if Map.member f functions
    --then fail $ "Function name " ++  peelId f ++ " is aready used"
    then fail "Function name is aready used"
    else return (Map.insert f funtyps functions, ctxs)

lookupVariable :: Environment -> Id -> Err Type
lookupVariable (functions, topctx:restctxs) v =
  case Map.lookup v topctx of
    Just typ  -> return typ
    Nothing   -> fail "Variable name not declared"

updateVariable :: Environment -> Id -> Type -> Err Environment
updateVariable (functions, topctx:restctxs) v typ =
  if Map.member v topctx
    then fail "Variable already declared in current block"
    else return (functions, Map.insert v typ topctx:restctxs)

newBlock :: Environment -> Environment
newBlock (functions, ctxs) = (functions, Map.empty : ctxs)

emptyEnvironment :: Environment
emptyEnvironment = (Map.empty, [])

typecheck :: Program -> Err ()
typecheck (PDefs defs) = do
  builtenv <- foldM -- foldM takes three arguments, namely the exact three lines below
    (\env (id, typs) -> updateFunction env (Id id) typs)
    emptyEnvironment
    [("printInt", ([Type_int], Type_void)), ("printDouble", ([Type_double], Type_void)), ("readInt", ([], Type_int)), ("readDouble", ([], Type_double))]
    -- skipping adding user def funcs.
  let globalenv = builtenv
  mapM
    (\(DFun outtyp id args stms) ->
      let
        retType = case outtyp of
          Type_void -> Nothing
          _         -> Just outtyp
      in do
        fbdyenv <- foldM -- foldM takes three arguments, namely the exact three lines below
          (\env (ADecl atyp aid) -> updateVariable env aid atyp)
          (newBlock globalenv)
          args
        typecheckStms fbdyenv retType stms
    )
    defs
  return ()

typecheckStms :: Environment -> Maybe Type -> [Stm] -> Err ()
typecheckStms env Nothing   []              = return ()
typecheckStms env (Just _)  []              = fail "Return stamement expected"
typecheckStms env (Just retType) [laststm]  =
  case laststm of
    SReturn exp -> typecheckExp env retType exp
    _           -> fail "Return stamement expected"
typecheckStms env retType (stm : stms)      = do
  env' <- typecheckStm env stm
  typecheckStms env' retType stms

typecheckStm :: Environment -> Stm -> Err Environment
typecheckStm _    (SReturn _) = fail "Return statement not expeced here"
typecheckStm env  (SExp exp)  = do
  _ <- typeinfer env exp
  return env

typecheckExp :: Environment -> Type -> Exp -> Err ()
typecheckExp env typ exp = do
  inftyp <- typeinfer env exp
  if typ == inftyp
    then return ()
    else fail $ "Expected type " ++ printTree typ ++ ", but found type " ++ printTree inftyp

typeinfer :: Environment -> Exp -> Err Type
typeinfer env exp =
  case exp of
    EId id            -> lookupVariable env id
    EInt _            -> return Type_int
    EDouble _         -> return Type_double
    ETrue             -> return Type_bool
    EFalse            -> return Type_bool
    EPlus exp1 exp2   -> do
      typecheckExp env Type_int exp1
      typecheckExp env Type_int exp2
      return Type_int
    EMinus exp1 exp2  -> do
      typecheckExp env Type_int exp1
      typecheckExp env Type_int exp2
      return Type_int
    ETimes exp1 exp2  -> do
      typecheckExp env Type_int exp1
      typecheckExp env Type_int exp2
      return Type_int
    EDiv exp1 exp2    -> do
      typecheckExp env Type_int exp1
      typecheckExp env Type_int exp2
      return Type_int
