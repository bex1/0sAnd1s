{-# OPTIONS_GHC -fno-warn-incomplete-patterns #-}
module PrintLab where

-- pretty-printer generated by the BNF converter

import AbsLab
import Data.Char


-- the top-level printing method
printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 (map ($ "") $ d []) "" where
  rend i ss = case ss of
    "["      :ts -> showChar '[' . rend i ts
    "("      :ts -> showChar '(' . rend i ts
    "{"      :ts -> showChar '{' . new (i+1) . rend (i+1) ts
    "}" : ";":ts -> new (i-1) . space "}" . showChar ';' . new (i-1) . rend (i-1) ts
    "}"      :ts -> new (i-1) . showChar '}' . new (i-1) . rend (i-1) ts
    ";"      :ts -> showChar ';' . new i . rend i ts
    t  : "," :ts -> showString t . space "," . rend i ts
    t  : ")" :ts -> showString t . showChar ')' . rend i ts
    t  : "]" :ts -> showString t . showChar ']' . rend i ts
    t        :ts -> space t . rend i ts
    _            -> id
  new i   = showChar '\n' . replicateS (2*i) (showChar ' ') . dropWhile isSpace
  space t = showString t . (\s -> if null s then "" else (' ':s))

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- the printer class does the job
class Print a where
  prt :: Int -> a -> Doc
  prtList :: Int -> [a] -> Doc
  prtList i = concatD . map (prt i)

instance Print a => Print [a] where
  prt = prtList

instance Print Char where
  prt _ s = doc (showChar '\'' . mkEsc '\'' s . showChar '\'')
  prtList _ s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q s = case s of
  _ | s == q -> showChar '\\' . showChar s
  '\\'-> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  _ -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j<i then parenth else id


instance Print Integer where
  prt _ x = doc (shows x)


instance Print Double where
  prt _ x = doc (shows x)



instance Print Id where
  prt _ (Id i) = doc (showString ( i))
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])


instance Print Program where
  prt i e = case e of
    Prog defs -> prPrec i 0 (concatD [prt 0 defs])

instance Print Def where
  prt i e = case e of
    DFun fun -> prPrec i 0 (concatD [prt 0 fun])
    DTDef tdef -> prPrec i 0 (concatD [prt 0 tdef, doc (showString ";")])
    DVar var -> prPrec i 0 (concatD [prt 0 var, doc (showString ";")])
    DStruct str -> prPrec i 0 (concatD [prt 0 str, doc (showString ";")])
    DUsing qconst -> prPrec i 0 (concatD [doc (showString "using"), prt 0 qconst, doc (showString ";")])
    DInline fun -> prPrec i 0 (concatD [doc (showString "inline"), prt 0 fun])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print Fun where
  prt i e = case e of
    FProto type_ id args -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString "("), prt 0 args, doc (showString ")"), doc (showString ";")])
    FDef type_ id args stms -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString "("), prt 0 args, doc (showString ")"), doc (showString "{"), prt 0 stms, doc (showString "}")])

instance Print TDef where
  prt i e = case e of
    Typedef type_ id -> prPrec i 0 (concatD [doc (showString "typedef"), prt 0 type_, prt 0 id])

instance Print Str where
  prt i e = case e of
    Struct id decs -> prPrec i 0 (concatD [doc (showString "struct"), prt 0 id, doc (showString "{"), prt 0 decs, doc (showString "}")])

instance Print Dec where
  prt i e = case e of
    DecSingle type_ id -> prPrec i 0 (concatD [prt 0 type_, prt 0 id])
    DecConst type_ id -> prPrec i 0 (concatD [doc (showString "const"), prt 0 type_, prt 0 id])
    DecInit type_ id exp -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString "="), prt 0 exp])
    DecInitConst type_ id exp -> prPrec i 0 (concatD [doc (showString "const"), prt 0 type_, prt 0 id, doc (showString "="), prt 0 exp])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])
instance Print Arg where
  prt i e = case e of
    ADec dec -> prPrec i 0 (concatD [prt 0 dec])
    ANoname type_ -> prPrec i 0 (concatD [prt 0 type_])
    ANonameConst type_ -> prPrec i 0 (concatD [doc (showString "const"), prt 0 type_])
  prtList _ [] = (concatD [])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
instance Print Var where
  prt i e = case e of
    VDec dec -> prPrec i 0 (concatD [prt 0 dec])
    VMult type_ id ids -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString ","), prt 0 ids])

instance Print Stm where
  prt i e = case e of
    SExpr exp -> prPrec i 0 (concatD [prt 0 exp, doc (showString ";")])
    SVar var -> prPrec i 0 (concatD [prt 0 var, doc (showString ";")])
    SRet exp -> prPrec i 0 (concatD [doc (showString "return"), prt 0 exp, doc (showString ";")])
    SBlock stms -> prPrec i 0 (concatD [doc (showString "{"), prt 0 stms, doc (showString "}")])
    SWhile exp stm -> prPrec i 0 (concatD [doc (showString "while"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm])
    SDoWhile stm exp -> prPrec i 0 (concatD [doc (showString "do"), prt 0 stm, doc (showString "while"), doc (showString "("), prt 0 exp, doc (showString ")"), doc (showString ";")])
    SFor var exp1 exp2 stm -> prPrec i 0 (concatD [doc (showString "for"), doc (showString "("), prt 0 var, doc (showString ";"), prt 0 exp1, doc (showString ";"), prt 0 exp2, doc (showString ")"), prt 0 stm])
    STDef tdef -> prPrec i 0 (concatD [prt 0 tdef, doc (showString ";")])
    SStruct str -> prPrec i 0 (concatD [prt 0 str, doc (showString ";")])
    SIf exp stm -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm])
    SIfElse exp stm1 stm2 -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm1, doc (showString "else"), prt 0 stm2])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print Exp where
  prt i e = case e of
    EInt n -> prPrec i 16 (concatD [prt 0 n])
    EDbl d -> prPrec i 16 (concatD [prt 0 d])
    EChar c -> prPrec i 16 (concatD [prt 0 c])
    EStrLit strs -> prPrec i 16 (concatD [prt 0 strs])
    EConst qconst -> prPrec i 15 (concatD [prt 0 qconst])
    EIndex id exp -> prPrec i 15 (concatD [prt 0 id, doc (showString "["), prt 0 exp, doc (showString "]")])
    EFunCall id exps -> prPrec i 15 (concatD [prt 0 id, doc (showString "("), prt 0 exps, doc (showString ")")])
    EStrDot exp1 exp2 -> prPrec i 14 (concatD [prt 14 exp1, doc (showString "."), prt 15 exp2])
    EStrArr exp1 exp2 -> prPrec i 14 (concatD [prt 14 exp1, doc (showString "->"), prt 15 exp2])
    EPostInc exp -> prPrec i 14 (concatD [prt 15 exp, doc (showString "++")])
    EDeref exp -> prPrec i 14 (concatD [doc (showString "*"), prt 15 exp])
    EPreInc exp -> prPrec i 13 (concatD [doc (showString "++"), prt 14 exp])
    ENegate exp -> prPrec i 13 (concatD [doc (showString "!"), prt 14 exp])
    EMul exp1 exp2 -> prPrec i 12 (concatD [prt 12 exp1, doc (showString "*"), prt 13 exp2])
    EDiv exp1 exp2 -> prPrec i 12 (concatD [prt 12 exp1, doc (showString "/"), prt 13 exp2])
    EMod exp1 exp2 -> prPrec i 12 (concatD [prt 12 exp1, doc (showString "%"), prt 13 exp2])
    EAdd exp1 exp2 -> prPrec i 11 (concatD [prt 11 exp1, doc (showString "+"), prt 12 exp2])
    ESub exp1 exp2 -> prPrec i 11 (concatD [prt 11 exp1, doc (showString "-"), prt 12 exp2])
    ELShift exp1 exp2 -> prPrec i 10 (concatD [prt 10 exp1, doc (showString "<<"), prt 11 exp2])
    ERShift exp1 exp2 -> prPrec i 10 (concatD [prt 11 exp1, doc (showString ">>"), prt 10 exp2])
    ELt exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString "<"), prt 10 exp2])
    EGt exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString ">"), prt 10 exp2])
    ELtEq exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString "<="), prt 10 exp2])
    EGtEq exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString ">="), prt 10 exp2])
    EEqual exp1 exp2 -> prPrec i 8 (concatD [prt 8 exp1, doc (showString "=="), prt 9 exp2])
    EIneq exp1 exp2 -> prPrec i 8 (concatD [prt 8 exp1, doc (showString "!="), prt 9 exp2])
    EAnd exp1 exp2 -> prPrec i 4 (concatD [prt 4 exp1, doc (showString "&&"), prt 5 exp2])
    EOr exp1 exp2 -> prPrec i 3 (concatD [prt 3 exp1, doc (showString "||"), prt 4 exp2])
    EAssign exp1 exp2 -> prPrec i 2 (concatD [prt 3 exp1, doc (showString "="), prt 2 exp2])
    EAssignInc exp1 exp2 -> prPrec i 2 (concatD [prt 3 exp1, doc (showString "+="), prt 2 exp2])
    EAssignDec exp1 exp2 -> prPrec i 2 (concatD [prt 3 exp1, doc (showString "-="), prt 2 exp2])
    ETernary exp1 exp2 exp3 -> prPrec i 2 (concatD [prt 3 exp1, doc (showString "?"), prt 3 exp2, doc (showString ":"), prt 3 exp3])
    EThrtow exp -> prPrec i 1 (concatD [doc (showString "throw"), prt 2 exp])
  prtList _ [] = (concatD [])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
instance Print Const where
  prt i e = case e of
    CTempl id types -> prPrec i 0 (concatD [prt 0 id, doc (showString "<"), prt 0 types, doc (showString ">")])
    CId id -> prPrec i 0 (concatD [prt 0 id])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString "::"), prt 0 xs])
instance Print QConst where
  prt i e = case e of
    QCon consts -> prPrec i 0 (concatD [prt 0 consts])

instance Print Type where
  prt i e = case e of
    TVoid -> prPrec i 0 (concatD [doc (showString "void")])
    TBool -> prPrec i 0 (concatD [doc (showString "bool")])
    TInt -> prPrec i 0 (concatD [doc (showString "int")])
    TDoube -> prPrec i 0 (concatD [doc (showString "double")])
    TConst qconst -> prPrec i 0 (concatD [prt 0 qconst])
    TRef type_ -> prPrec i 0 (concatD [prt 0 type_, doc (showString "&")])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
