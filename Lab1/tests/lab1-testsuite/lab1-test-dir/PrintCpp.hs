{-# OPTIONS_GHC -fno-warn-incomplete-patterns #-}
module PrintCpp where

-- pretty-printer generated by the BNF converter

import AbsCpp
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
    DInlFun fun -> prPrec i 0 (concatD [doc (showString "inline"), prt 0 fun])
    DTDef tdef -> prPrec i 0 (concatD [prt 0 tdef, doc (showString ";")])
    DVar stmdec -> prPrec i 0 (concatD [prt 0 stmdec, doc (showString ";")])
    DStruct struct -> prPrec i 0 (concatD [prt 0 struct, doc (showString ";")])
    DUsing qconst -> prPrec i 0 (concatD [doc (showString "using"), prt 0 qconst, doc (showString ";")])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print Fun where
  prt i e = case e of
    FProto type_ id argdecs -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString "("), prt 0 argdecs, doc (showString ")"), doc (showString ";")])
    FDef type_ id argdecs stms -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString "("), prt 0 argdecs, doc (showString ")"), doc (showString "{"), prt 0 stms, doc (showString "}")])

instance Print TDef where
  prt i e = case e of
    Typedef type_ id -> prPrec i 0 (concatD [doc (showString "typedef"), prt 0 type_, prt 0 id])

instance Print Struct where
  prt i e = case e of
    Structure id decs -> prPrec i 0 (concatD [doc (showString "struct"), prt 0 id, doc (showString "{"), prt 0 decs, doc (showString "}")])

instance Print Dec where
  prt i e = case e of
    DecSingle type_ id -> prPrec i 0 (concatD [prt 0 type_, prt 0 id])
    DecConst type_ id -> prPrec i 0 (concatD [doc (showString "const"), prt 0 type_, prt 0 id])
    DecInit type_ id exp -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString "="), prt 0 exp])
    DecInitConst type_ id exp -> prPrec i 0 (concatD [doc (showString "const"), prt 0 type_, prt 0 id, doc (showString "="), prt 0 exp])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ";"), prt 0 xs])
instance Print ArgDec where
  prt i e = case e of
    DecArg dec -> prPrec i 0 (concatD [prt 0 dec])
    DecArgNoName type_ -> prPrec i 0 (concatD [prt 0 type_])
    DecArgCNoName type_ -> prPrec i 0 (concatD [doc (showString "const"), prt 0 type_])
  prtList _ [] = (concatD [])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])
instance Print StmDec where
  prt i e = case e of
    DecVar dec -> prPrec i 0 (concatD [prt 0 dec])
    DecMultVar type_ id ids -> prPrec i 0 (concatD [prt 0 type_, prt 0 id, doc (showString ","), prt 0 ids])

instance Print Stm where
  prt i e = case e of
    SExpr exp -> prPrec i 0 (concatD [prt 0 exp, doc (showString ";")])
    SStmDec stmdec -> prPrec i 0 (concatD [prt 0 stmdec, doc (showString ";")])
    SReturn exp -> prPrec i 0 (concatD [doc (showString "return"), prt 0 exp, doc (showString ";")])
    SWhile exp stm -> prPrec i 0 (concatD [doc (showString "while"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm])
    SDoWhile stm exp -> prPrec i 0 (concatD [doc (showString "do"), prt 0 stm, doc (showString "while"), doc (showString "("), prt 0 exp, doc (showString ")"), doc (showString ";")])
    SFor stmdec exp1 exp2 stm -> prPrec i 0 (concatD [doc (showString "for"), doc (showString "("), prt 0 stmdec, doc (showString ";"), prt 0 exp1, doc (showString ";"), prt 0 exp2, doc (showString ")"), prt 0 stm])
    SIf exp stm -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm])
    SIfElse exp stm1 stm2 -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 exp, doc (showString ")"), prt 0 stm1, doc (showString "else"), prt 0 stm2])
    SBlock stms -> prPrec i 0 (concatD [doc (showString "{"), prt 0 stms, doc (showString "}")])
    STDef tdef -> prPrec i 0 (concatD [prt 0 tdef, doc (showString ";")])
    SStruct struct -> prPrec i 0 (concatD [prt 0 struct, doc (showString ";")])
  prtList _ [] = (concatD [])
  prtList _ (x:xs) = (concatD [prt 0 x, prt 0 xs])
instance Print Exp where
  prt i e = case e of
    EInt n -> prPrec i 16 (concatD [prt 0 n])
    EDouble d -> prPrec i 16 (concatD [prt 0 d])
    EChar c -> prPrec i 16 (concatD [prt 0 c])
    EString strs -> prPrec i 16 (concatD [prt 0 strs])
    ETrue -> prPrec i 16 (concatD [doc (showString "true")])
    EFalse -> prPrec i 16 (concatD [doc (showString "false")])
    EConst qconst -> prPrec i 16 (concatD [prt 0 qconst])
    EIndex id exp -> prPrec i 15 (concatD [prt 0 id, doc (showString "["), prt 0 exp, doc (showString "]")])
    ECall id exps -> prPrec i 15 (concatD [prt 0 id, doc (showString "("), prt 0 exps, doc (showString ")")])
    EMem exp1 exp2 -> prPrec i 14 (concatD [prt 14 exp1, doc (showString "."), prt 15 exp2])
    EFAccs exp1 exp2 -> prPrec i 14 (concatD [prt 14 exp1, doc (showString "->"), prt 15 exp2])
    EPostInc exp -> prPrec i 14 (concatD [prt 15 exp, doc (showString "++")])
    EPostDec exp -> prPrec i 14 (concatD [prt 15 exp, doc (showString "--")])
    EPreInc exp -> prPrec i 13 (concatD [doc (showString "++"), prt 14 exp])
    EPreDec exp -> prPrec i 13 (concatD [doc (showString "--"), prt 14 exp])
    EDeref exp -> prPrec i 13 (concatD [doc (showString "*"), prt 14 exp])
    ENot exp -> prPrec i 13 (concatD [doc (showString "!"), prt 14 exp])
    ENeg exp -> prPrec i 13 (concatD [doc (showString "-"), prt 14 exp])
    EMul exp1 exp2 -> prPrec i 12 (concatD [prt 12 exp1, doc (showString "*"), prt 13 exp2])
    EDiv exp1 exp2 -> prPrec i 12 (concatD [prt 12 exp1, doc (showString "/"), prt 13 exp2])
    EMod exp1 exp2 -> prPrec i 12 (concatD [prt 12 exp1, doc (showString "%"), prt 13 exp2])
    EAdd exp1 exp2 -> prPrec i 11 (concatD [prt 11 exp1, doc (showString "+"), prt 12 exp2])
    ESub exp1 exp2 -> prPrec i 11 (concatD [prt 11 exp1, doc (showString "-"), prt 12 exp2])
    EShiftL exp1 exp2 -> prPrec i 10 (concatD [prt 10 exp1, doc (showString "<<"), prt 11 exp2])
    EShiftR exp1 exp2 -> prPrec i 10 (concatD [prt 10 exp1, doc (showString ">>"), prt 11 exp2])
    EGt exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString ">"), prt 10 exp2])
    ELt exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString "<"), prt 10 exp2])
    ELeq exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString "<="), prt 10 exp2])
    EGeq exp1 exp2 -> prPrec i 9 (concatD [prt 9 exp1, doc (showString ">="), prt 10 exp2])
    ENeq exp1 exp2 -> prPrec i 8 (concatD [prt 8 exp1, doc (showString "!="), prt 9 exp2])
    EEq exp1 exp2 -> prPrec i 8 (concatD [prt 8 exp1, doc (showString "=="), prt 9 exp2])
    EAnd exp1 exp2 -> prPrec i 4 (concatD [prt 4 exp1, doc (showString "&&"), prt 5 exp2])
    EOr exp1 exp2 -> prPrec i 3 (concatD [prt 3 exp1, doc (showString "||"), prt 4 exp2])
    EAss exp1 exp2 -> prPrec i 2 (concatD [prt 3 exp1, doc (showString "="), prt 2 exp2])
    EAssDec exp1 exp2 -> prPrec i 2 (concatD [prt 3 exp1, doc (showString "-="), prt 2 exp2])
    EAssInc exp1 exp2 -> prPrec i 2 (concatD [prt 3 exp1, doc (showString "+="), prt 2 exp2])
    EIfElse exp1 exp2 exp3 -> prPrec i 2 (concatD [prt 3 exp1, doc (showString "?"), prt 2 exp2, doc (showString ":"), prt 2 exp3])
    EThrow exp -> prPrec i 1 (concatD [doc (showString "throw"), prt 2 exp])
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
    TInt -> prPrec i 0 (concatD [doc (showString "int")])
    TDouble -> prPrec i 0 (concatD [doc (showString "double")])
    TVoid -> prPrec i 0 (concatD [doc (showString "void")])
    TBool -> prPrec i 0 (concatD [doc (showString "bool")])
    TConst qconst -> prPrec i 0 (concatD [prt 0 qconst])
    TRef type_ -> prPrec i 0 (concatD [prt 0 type_, doc (showString "&")])
  prtList _ [x] = (concatD [prt 0 x])
  prtList _ (x:xs) = (concatD [prt 0 x, doc (showString ","), prt 0 xs])

