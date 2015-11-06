{-# OPTIONS_GHC -w #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParCpp where
import AbsCpp
import LexCpp
import ErrM
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Integer)
	| HappyAbsSyn5 (Double)
	| HappyAbsSyn6 (Char)
	| HappyAbsSyn7 (String)
	| HappyAbsSyn8 (Id)
	| HappyAbsSyn9 (Program)
	| HappyAbsSyn10 ([Def])
	| HappyAbsSyn11 (Def)
	| HappyAbsSyn12 (Fun)
	| HappyAbsSyn13 ([Arg])
	| HappyAbsSyn14 (TDef)
	| HappyAbsSyn15 (Str)
	| HappyAbsSyn16 ([Dec])
	| HappyAbsSyn17 (Dec)
	| HappyAbsSyn18 (Arg)
	| HappyAbsSyn19 (Var)
	| HappyAbsSyn20 ([Id])
	| HappyAbsSyn21 (Stm)
	| HappyAbsSyn22 ([Stm])
	| HappyAbsSyn23 (Exp)
	| HappyAbsSyn36 ([Exp])
	| HappyAbsSyn37 ([String])
	| HappyAbsSyn42 (Const)
	| HappyAbsSyn43 (QConst)
	| HappyAbsSyn44 ([Const])
	| HappyAbsSyn45 ([Type])
	| HappyAbsSyn46 (Type)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163,
 action_164,
 action_165,
 action_166,
 action_167,
 action_168,
 action_169,
 action_170,
 action_171,
 action_172,
 action_173,
 action_174,
 action_175,
 action_176,
 action_177,
 action_178,
 action_179,
 action_180,
 action_181,
 action_182,
 action_183,
 action_184,
 action_185,
 action_186,
 action_187,
 action_188,
 action_189,
 action_190,
 action_191,
 action_192,
 action_193,
 action_194,
 action_195,
 action_196,
 action_197,
 action_198,
 action_199,
 action_200,
 action_201,
 action_202,
 action_203,
 action_204,
 action_205,
 action_206,
 action_207,
 action_208,
 action_209,
 action_210,
 action_211,
 action_212,
 action_213,
 action_214,
 action_215,
 action_216 :: () => Int -> ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86,
 happyReduce_87,
 happyReduce_88,
 happyReduce_89,
 happyReduce_90,
 happyReduce_91,
 happyReduce_92,
 happyReduce_93,
 happyReduce_94,
 happyReduce_95,
 happyReduce_96,
 happyReduce_97,
 happyReduce_98,
 happyReduce_99,
 happyReduce_100,
 happyReduce_101,
 happyReduce_102,
 happyReduce_103,
 happyReduce_104,
 happyReduce_105,
 happyReduce_106,
 happyReduce_107,
 happyReduce_108,
 happyReduce_109,
 happyReduce_110,
 happyReduce_111,
 happyReduce_112,
 happyReduce_113,
 happyReduce_114,
 happyReduce_115 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

action_0 (9) = happyGoto action_3
action_0 (10) = happyGoto action_4
action_0 _ = happyReduce_7

action_1 (97) = happyShift action_2
action_1 _ = happyFail

action_2 _ = happyReduce_1

action_3 (102) = happyAccept
action_3 _ = happyFail

action_4 (78) = happyShift action_16
action_4 (79) = happyShift action_17
action_4 (81) = happyShift action_18
action_4 (85) = happyShift action_19
action_4 (86) = happyShift action_20
action_4 (88) = happyShift action_21
action_4 (90) = happyShift action_22
action_4 (91) = happyShift action_23
action_4 (92) = happyShift action_24
action_4 (101) = happyShift action_25
action_4 (8) = happyGoto action_5
action_4 (11) = happyGoto action_6
action_4 (12) = happyGoto action_7
action_4 (14) = happyGoto action_8
action_4 (15) = happyGoto action_9
action_4 (17) = happyGoto action_10
action_4 (19) = happyGoto action_11
action_4 (42) = happyGoto action_12
action_4 (43) = happyGoto action_13
action_4 (44) = happyGoto action_14
action_4 (46) = happyGoto action_15
action_4 _ = happyReduce_6

action_5 (67) = happyShift action_38
action_5 _ = happyReduce_104

action_6 _ = happyReduce_8

action_7 _ = happyReduce_9

action_8 (66) = happyShift action_37
action_8 _ = happyFail

action_9 (66) = happyShift action_36
action_9 _ = happyFail

action_10 _ = happyReduce_31

action_11 (66) = happyShift action_35
action_11 _ = happyFail

action_12 (65) = happyShift action_34
action_12 _ = happyReduce_106

action_13 _ = happyReduce_114

action_14 _ = happyReduce_105

action_15 (50) = happyShift action_33
action_15 (101) = happyShift action_25
action_15 (8) = happyGoto action_32
action_15 _ = happyFail

action_16 _ = happyReduce_111

action_17 (78) = happyShift action_16
action_17 (81) = happyShift action_18
action_17 (86) = happyShift action_20
action_17 (92) = happyShift action_24
action_17 (101) = happyShift action_25
action_17 (8) = happyGoto action_5
action_17 (42) = happyGoto action_12
action_17 (43) = happyGoto action_13
action_17 (44) = happyGoto action_14
action_17 (46) = happyGoto action_31
action_17 _ = happyFail

action_18 _ = happyReduce_113

action_19 (78) = happyShift action_16
action_19 (81) = happyShift action_18
action_19 (86) = happyShift action_20
action_19 (92) = happyShift action_24
action_19 (101) = happyShift action_25
action_19 (8) = happyGoto action_5
action_19 (12) = happyGoto action_29
action_19 (42) = happyGoto action_12
action_19 (43) = happyGoto action_13
action_19 (44) = happyGoto action_14
action_19 (46) = happyGoto action_30
action_19 _ = happyFail

action_20 _ = happyReduce_112

action_21 (101) = happyShift action_25
action_21 (8) = happyGoto action_28
action_21 _ = happyFail

action_22 (78) = happyShift action_16
action_22 (81) = happyShift action_18
action_22 (86) = happyShift action_20
action_22 (92) = happyShift action_24
action_22 (101) = happyShift action_25
action_22 (8) = happyGoto action_5
action_22 (42) = happyGoto action_12
action_22 (43) = happyGoto action_13
action_22 (44) = happyGoto action_14
action_22 (46) = happyGoto action_27
action_22 _ = happyFail

action_23 (101) = happyShift action_25
action_23 (8) = happyGoto action_5
action_23 (42) = happyGoto action_12
action_23 (43) = happyGoto action_26
action_23 (44) = happyGoto action_14
action_23 _ = happyFail

action_24 _ = happyReduce_110

action_25 _ = happyReduce_5

action_26 (66) = happyShift action_49
action_26 _ = happyFail

action_27 (50) = happyShift action_33
action_27 (101) = happyShift action_25
action_27 (8) = happyGoto action_48
action_27 _ = happyFail

action_28 (94) = happyShift action_47
action_28 _ = happyFail

action_29 _ = happyReduce_14

action_30 (50) = happyShift action_33
action_30 (101) = happyShift action_25
action_30 (8) = happyGoto action_46
action_30 _ = happyFail

action_31 (50) = happyShift action_33
action_31 (101) = happyShift action_25
action_31 (8) = happyGoto action_45
action_31 _ = happyFail

action_32 (52) = happyShift action_42
action_32 (58) = happyShift action_43
action_32 (70) = happyShift action_44
action_32 _ = happyReduce_24

action_33 _ = happyReduce_115

action_34 (101) = happyShift action_25
action_34 (8) = happyGoto action_5
action_34 (42) = happyGoto action_12
action_34 (44) = happyGoto action_41
action_34 _ = happyFail

action_35 _ = happyReduce_11

action_36 _ = happyReduce_12

action_37 _ = happyReduce_10

action_38 (78) = happyShift action_16
action_38 (81) = happyShift action_18
action_38 (86) = happyShift action_20
action_38 (92) = happyShift action_24
action_38 (101) = happyShift action_25
action_38 (8) = happyGoto action_5
action_38 (42) = happyGoto action_12
action_38 (43) = happyGoto action_13
action_38 (44) = happyGoto action_14
action_38 (45) = happyGoto action_39
action_38 (46) = happyGoto action_40
action_38 _ = happyFail

action_39 (72) = happyShift action_92
action_39 _ = happyFail

action_40 (50) = happyShift action_33
action_40 (58) = happyShift action_91
action_40 _ = happyReduce_108

action_41 _ = happyReduce_107

action_42 (78) = happyShift action_16
action_42 (79) = happyShift action_90
action_42 (81) = happyShift action_18
action_42 (86) = happyShift action_20
action_42 (92) = happyShift action_24
action_42 (101) = happyShift action_25
action_42 (8) = happyGoto action_5
action_42 (13) = happyGoto action_86
action_42 (17) = happyGoto action_87
action_42 (18) = happyGoto action_88
action_42 (42) = happyGoto action_12
action_42 (43) = happyGoto action_13
action_42 (44) = happyGoto action_14
action_42 (46) = happyGoto action_89
action_42 _ = happyReduce_17

action_43 (101) = happyShift action_25
action_43 (8) = happyGoto action_84
action_43 (20) = happyGoto action_85
action_43 _ = happyFail

action_44 (47) = happyShift action_76
action_44 (52) = happyShift action_77
action_44 (54) = happyShift action_78
action_44 (56) = happyShift action_79
action_44 (89) = happyShift action_80
action_44 (97) = happyShift action_2
action_44 (98) = happyShift action_81
action_44 (99) = happyShift action_82
action_44 (100) = happyShift action_83
action_44 (101) = happyShift action_25
action_44 (4) = happyGoto action_52
action_44 (5) = happyGoto action_53
action_44 (6) = happyGoto action_54
action_44 (7) = happyGoto action_55
action_44 (8) = happyGoto action_56
action_44 (23) = happyGoto action_57
action_44 (24) = happyGoto action_58
action_44 (25) = happyGoto action_59
action_44 (26) = happyGoto action_60
action_44 (27) = happyGoto action_61
action_44 (28) = happyGoto action_62
action_44 (29) = happyGoto action_63
action_44 (30) = happyGoto action_64
action_44 (31) = happyGoto action_65
action_44 (32) = happyGoto action_66
action_44 (33) = happyGoto action_67
action_44 (34) = happyGoto action_68
action_44 (35) = happyGoto action_69
action_44 (37) = happyGoto action_70
action_44 (38) = happyGoto action_71
action_44 (39) = happyGoto action_72
action_44 (40) = happyGoto action_73
action_44 (41) = happyGoto action_74
action_44 (42) = happyGoto action_12
action_44 (43) = happyGoto action_75
action_44 (44) = happyGoto action_14
action_44 _ = happyFail

action_45 (70) = happyShift action_51
action_45 _ = happyReduce_25

action_46 (52) = happyShift action_42
action_46 _ = happyFail

action_47 (16) = happyGoto action_50
action_47 _ = happyReduce_22

action_48 _ = happyReduce_20

action_49 _ = happyReduce_13

action_50 (78) = happyShift action_16
action_50 (79) = happyShift action_17
action_50 (81) = happyShift action_18
action_50 (86) = happyShift action_20
action_50 (92) = happyShift action_24
action_50 (96) = happyShift action_132
action_50 (101) = happyShift action_25
action_50 (8) = happyGoto action_5
action_50 (17) = happyGoto action_130
action_50 (42) = happyGoto action_12
action_50 (43) = happyGoto action_13
action_50 (44) = happyGoto action_14
action_50 (46) = happyGoto action_131
action_50 _ = happyFail

action_51 (47) = happyShift action_76
action_51 (52) = happyShift action_77
action_51 (54) = happyShift action_78
action_51 (56) = happyShift action_79
action_51 (89) = happyShift action_80
action_51 (97) = happyShift action_2
action_51 (98) = happyShift action_81
action_51 (99) = happyShift action_82
action_51 (100) = happyShift action_83
action_51 (101) = happyShift action_25
action_51 (4) = happyGoto action_52
action_51 (5) = happyGoto action_53
action_51 (6) = happyGoto action_54
action_51 (7) = happyGoto action_55
action_51 (8) = happyGoto action_56
action_51 (23) = happyGoto action_57
action_51 (24) = happyGoto action_58
action_51 (25) = happyGoto action_59
action_51 (26) = happyGoto action_60
action_51 (27) = happyGoto action_61
action_51 (28) = happyGoto action_62
action_51 (29) = happyGoto action_63
action_51 (30) = happyGoto action_64
action_51 (31) = happyGoto action_65
action_51 (32) = happyGoto action_66
action_51 (33) = happyGoto action_67
action_51 (34) = happyGoto action_68
action_51 (35) = happyGoto action_69
action_51 (37) = happyGoto action_70
action_51 (38) = happyGoto action_129
action_51 (39) = happyGoto action_72
action_51 (40) = happyGoto action_73
action_51 (41) = happyGoto action_74
action_51 (42) = happyGoto action_12
action_51 (43) = happyGoto action_75
action_51 (44) = happyGoto action_14
action_51 _ = happyFail

action_52 _ = happyReduce_48

action_53 _ = happyReduce_49

action_54 _ = happyReduce_50

action_55 (100) = happyShift action_83
action_55 (7) = happyGoto action_55
action_55 (37) = happyGoto action_128
action_55 _ = happyReduce_97

action_56 (52) = happyShift action_126
action_56 (67) = happyShift action_38
action_56 (76) = happyShift action_127
action_56 _ = happyReduce_104

action_57 _ = happyReduce_56

action_58 (56) = happyShift action_125
action_58 _ = happyReduce_61

action_59 (61) = happyShift action_123
action_59 (62) = happyShift action_124
action_59 _ = happyReduce_64

action_60 _ = happyReduce_68

action_61 (49) = happyShift action_120
action_61 (54) = happyShift action_121
action_61 (63) = happyShift action_122
action_61 _ = happyReduce_71

action_62 (55) = happyShift action_117
action_62 (59) = happyShift action_118
action_62 (74) = happyShift action_119
action_62 _ = happyReduce_74

action_63 (68) = happyShift action_116
action_63 _ = happyReduce_79

action_64 (67) = happyShift action_112
action_64 (69) = happyShift action_113
action_64 (72) = happyShift action_114
action_64 (73) = happyShift action_115
action_64 _ = happyReduce_82

action_65 (48) = happyShift action_110
action_65 (71) = happyShift action_111
action_65 _ = happyReduce_102

action_66 (51) = happyShift action_109
action_66 _ = happyReduce_86

action_67 (57) = happyShift action_104
action_67 (60) = happyShift action_105
action_67 (70) = happyShift action_106
action_67 (75) = happyShift action_107
action_67 (95) = happyShift action_108
action_67 _ = happyReduce_91

action_68 _ = happyReduce_93

action_69 _ = happyReduce_99

action_70 _ = happyReduce_51

action_71 _ = happyReduce_26

action_72 _ = happyReduce_84

action_73 _ = happyReduce_100

action_74 _ = happyReduce_101

action_75 _ = happyReduce_53

action_76 (52) = happyShift action_77
action_76 (54) = happyShift action_78
action_76 (97) = happyShift action_2
action_76 (98) = happyShift action_81
action_76 (99) = happyShift action_82
action_76 (100) = happyShift action_83
action_76 (101) = happyShift action_25
action_76 (4) = happyGoto action_52
action_76 (5) = happyGoto action_53
action_76 (6) = happyGoto action_54
action_76 (7) = happyGoto action_55
action_76 (8) = happyGoto action_56
action_76 (23) = happyGoto action_57
action_76 (24) = happyGoto action_58
action_76 (25) = happyGoto action_103
action_76 (37) = happyGoto action_70
action_76 (42) = happyGoto action_12
action_76 (43) = happyGoto action_75
action_76 (44) = happyGoto action_14
action_76 _ = happyFail

action_77 (47) = happyShift action_76
action_77 (52) = happyShift action_77
action_77 (54) = happyShift action_78
action_77 (56) = happyShift action_79
action_77 (89) = happyShift action_80
action_77 (97) = happyShift action_2
action_77 (98) = happyShift action_81
action_77 (99) = happyShift action_82
action_77 (100) = happyShift action_83
action_77 (101) = happyShift action_25
action_77 (4) = happyGoto action_52
action_77 (5) = happyGoto action_53
action_77 (6) = happyGoto action_54
action_77 (7) = happyGoto action_55
action_77 (8) = happyGoto action_56
action_77 (23) = happyGoto action_57
action_77 (24) = happyGoto action_58
action_77 (25) = happyGoto action_59
action_77 (26) = happyGoto action_60
action_77 (27) = happyGoto action_61
action_77 (28) = happyGoto action_62
action_77 (29) = happyGoto action_63
action_77 (30) = happyGoto action_64
action_77 (31) = happyGoto action_65
action_77 (32) = happyGoto action_66
action_77 (33) = happyGoto action_67
action_77 (34) = happyGoto action_68
action_77 (35) = happyGoto action_69
action_77 (37) = happyGoto action_70
action_77 (38) = happyGoto action_102
action_77 (39) = happyGoto action_72
action_77 (40) = happyGoto action_73
action_77 (41) = happyGoto action_74
action_77 (42) = happyGoto action_12
action_77 (43) = happyGoto action_75
action_77 (44) = happyGoto action_14
action_77 _ = happyFail

action_78 (52) = happyShift action_77
action_78 (97) = happyShift action_2
action_78 (98) = happyShift action_81
action_78 (99) = happyShift action_82
action_78 (100) = happyShift action_83
action_78 (101) = happyShift action_25
action_78 (4) = happyGoto action_52
action_78 (5) = happyGoto action_53
action_78 (6) = happyGoto action_54
action_78 (7) = happyGoto action_55
action_78 (8) = happyGoto action_56
action_78 (23) = happyGoto action_57
action_78 (24) = happyGoto action_101
action_78 (37) = happyGoto action_70
action_78 (42) = happyGoto action_12
action_78 (43) = happyGoto action_75
action_78 (44) = happyGoto action_14
action_78 _ = happyFail

action_79 (52) = happyShift action_77
action_79 (54) = happyShift action_78
action_79 (97) = happyShift action_2
action_79 (98) = happyShift action_81
action_79 (99) = happyShift action_82
action_79 (100) = happyShift action_83
action_79 (101) = happyShift action_25
action_79 (4) = happyGoto action_52
action_79 (5) = happyGoto action_53
action_79 (6) = happyGoto action_54
action_79 (7) = happyGoto action_55
action_79 (8) = happyGoto action_56
action_79 (23) = happyGoto action_57
action_79 (24) = happyGoto action_58
action_79 (25) = happyGoto action_100
action_79 (37) = happyGoto action_70
action_79 (42) = happyGoto action_12
action_79 (43) = happyGoto action_75
action_79 (44) = happyGoto action_14
action_79 _ = happyFail

action_80 (47) = happyShift action_76
action_80 (52) = happyShift action_77
action_80 (54) = happyShift action_78
action_80 (56) = happyShift action_79
action_80 (97) = happyShift action_2
action_80 (98) = happyShift action_81
action_80 (99) = happyShift action_82
action_80 (100) = happyShift action_83
action_80 (101) = happyShift action_25
action_80 (4) = happyGoto action_52
action_80 (5) = happyGoto action_53
action_80 (6) = happyGoto action_54
action_80 (7) = happyGoto action_55
action_80 (8) = happyGoto action_56
action_80 (23) = happyGoto action_57
action_80 (24) = happyGoto action_58
action_80 (25) = happyGoto action_59
action_80 (26) = happyGoto action_60
action_80 (27) = happyGoto action_61
action_80 (28) = happyGoto action_62
action_80 (29) = happyGoto action_63
action_80 (30) = happyGoto action_64
action_80 (31) = happyGoto action_65
action_80 (32) = happyGoto action_66
action_80 (33) = happyGoto action_67
action_80 (34) = happyGoto action_99
action_80 (37) = happyGoto action_70
action_80 (39) = happyGoto action_72
action_80 (40) = happyGoto action_73
action_80 (41) = happyGoto action_74
action_80 (42) = happyGoto action_12
action_80 (43) = happyGoto action_75
action_80 (44) = happyGoto action_14
action_80 _ = happyFail

action_81 _ = happyReduce_2

action_82 _ = happyReduce_3

action_83 _ = happyReduce_4

action_84 (58) = happyShift action_98
action_84 _ = happyReduce_33

action_85 _ = happyReduce_32

action_86 (53) = happyShift action_97
action_86 _ = happyFail

action_87 _ = happyReduce_28

action_88 (58) = happyShift action_96
action_88 _ = happyReduce_18

action_89 (50) = happyShift action_33
action_89 (101) = happyShift action_25
action_89 (8) = happyGoto action_95
action_89 _ = happyReduce_29

action_90 (78) = happyShift action_16
action_90 (81) = happyShift action_18
action_90 (86) = happyShift action_20
action_90 (92) = happyShift action_24
action_90 (101) = happyShift action_25
action_90 (8) = happyGoto action_5
action_90 (42) = happyGoto action_12
action_90 (43) = happyGoto action_13
action_90 (44) = happyGoto action_14
action_90 (46) = happyGoto action_94
action_90 _ = happyFail

action_91 (78) = happyShift action_16
action_91 (81) = happyShift action_18
action_91 (86) = happyShift action_20
action_91 (92) = happyShift action_24
action_91 (101) = happyShift action_25
action_91 (8) = happyGoto action_5
action_91 (42) = happyGoto action_12
action_91 (43) = happyGoto action_13
action_91 (44) = happyGoto action_14
action_91 (45) = happyGoto action_93
action_91 (46) = happyGoto action_40
action_91 _ = happyFail

action_92 _ = happyReduce_103

action_93 _ = happyReduce_109

action_94 (50) = happyShift action_33
action_94 (101) = happyShift action_25
action_94 (8) = happyGoto action_45
action_94 _ = happyReduce_30

action_95 (70) = happyShift action_44
action_95 _ = happyReduce_24

action_96 (78) = happyShift action_16
action_96 (79) = happyShift action_90
action_96 (81) = happyShift action_18
action_96 (86) = happyShift action_20
action_96 (92) = happyShift action_24
action_96 (101) = happyShift action_25
action_96 (8) = happyGoto action_5
action_96 (13) = happyGoto action_162
action_96 (17) = happyGoto action_87
action_96 (18) = happyGoto action_88
action_96 (42) = happyGoto action_12
action_96 (43) = happyGoto action_13
action_96 (44) = happyGoto action_14
action_96 (46) = happyGoto action_89
action_96 _ = happyReduce_17

action_97 (66) = happyShift action_160
action_97 (94) = happyShift action_161
action_97 _ = happyFail

action_98 (101) = happyShift action_25
action_98 (8) = happyGoto action_84
action_98 (20) = happyGoto action_159
action_98 _ = happyFail

action_99 _ = happyReduce_92

action_100 (61) = happyShift action_123
action_100 (62) = happyShift action_124
action_100 _ = happyReduce_62

action_101 _ = happyReduce_60

action_102 (53) = happyShift action_158
action_102 _ = happyFail

action_103 (61) = happyShift action_123
action_103 (62) = happyShift action_124
action_103 _ = happyReduce_63

action_104 (47) = happyShift action_76
action_104 (52) = happyShift action_77
action_104 (54) = happyShift action_78
action_104 (56) = happyShift action_79
action_104 (97) = happyShift action_2
action_104 (98) = happyShift action_81
action_104 (99) = happyShift action_82
action_104 (100) = happyShift action_83
action_104 (101) = happyShift action_25
action_104 (4) = happyGoto action_52
action_104 (5) = happyGoto action_53
action_104 (6) = happyGoto action_54
action_104 (7) = happyGoto action_55
action_104 (8) = happyGoto action_56
action_104 (23) = happyGoto action_57
action_104 (24) = happyGoto action_58
action_104 (25) = happyGoto action_59
action_104 (26) = happyGoto action_60
action_104 (27) = happyGoto action_61
action_104 (28) = happyGoto action_62
action_104 (29) = happyGoto action_63
action_104 (30) = happyGoto action_64
action_104 (31) = happyGoto action_65
action_104 (32) = happyGoto action_66
action_104 (33) = happyGoto action_67
action_104 (34) = happyGoto action_157
action_104 (37) = happyGoto action_70
action_104 (39) = happyGoto action_72
action_104 (40) = happyGoto action_73
action_104 (41) = happyGoto action_74
action_104 (42) = happyGoto action_12
action_104 (43) = happyGoto action_75
action_104 (44) = happyGoto action_14
action_104 _ = happyFail

action_105 (47) = happyShift action_76
action_105 (52) = happyShift action_77
action_105 (54) = happyShift action_78
action_105 (56) = happyShift action_79
action_105 (97) = happyShift action_2
action_105 (98) = happyShift action_81
action_105 (99) = happyShift action_82
action_105 (100) = happyShift action_83
action_105 (101) = happyShift action_25
action_105 (4) = happyGoto action_52
action_105 (5) = happyGoto action_53
action_105 (6) = happyGoto action_54
action_105 (7) = happyGoto action_55
action_105 (8) = happyGoto action_56
action_105 (23) = happyGoto action_57
action_105 (24) = happyGoto action_58
action_105 (25) = happyGoto action_59
action_105 (26) = happyGoto action_60
action_105 (27) = happyGoto action_61
action_105 (28) = happyGoto action_62
action_105 (29) = happyGoto action_63
action_105 (30) = happyGoto action_64
action_105 (31) = happyGoto action_65
action_105 (32) = happyGoto action_66
action_105 (33) = happyGoto action_67
action_105 (34) = happyGoto action_156
action_105 (37) = happyGoto action_70
action_105 (39) = happyGoto action_72
action_105 (40) = happyGoto action_73
action_105 (41) = happyGoto action_74
action_105 (42) = happyGoto action_12
action_105 (43) = happyGoto action_75
action_105 (44) = happyGoto action_14
action_105 _ = happyFail

action_106 (47) = happyShift action_76
action_106 (52) = happyShift action_77
action_106 (54) = happyShift action_78
action_106 (56) = happyShift action_79
action_106 (97) = happyShift action_2
action_106 (98) = happyShift action_81
action_106 (99) = happyShift action_82
action_106 (100) = happyShift action_83
action_106 (101) = happyShift action_25
action_106 (4) = happyGoto action_52
action_106 (5) = happyGoto action_53
action_106 (6) = happyGoto action_54
action_106 (7) = happyGoto action_55
action_106 (8) = happyGoto action_56
action_106 (23) = happyGoto action_57
action_106 (24) = happyGoto action_58
action_106 (25) = happyGoto action_59
action_106 (26) = happyGoto action_60
action_106 (27) = happyGoto action_61
action_106 (28) = happyGoto action_62
action_106 (29) = happyGoto action_63
action_106 (30) = happyGoto action_64
action_106 (31) = happyGoto action_65
action_106 (32) = happyGoto action_66
action_106 (33) = happyGoto action_67
action_106 (34) = happyGoto action_155
action_106 (37) = happyGoto action_70
action_106 (39) = happyGoto action_72
action_106 (40) = happyGoto action_73
action_106 (41) = happyGoto action_74
action_106 (42) = happyGoto action_12
action_106 (43) = happyGoto action_75
action_106 (44) = happyGoto action_14
action_106 _ = happyFail

action_107 (47) = happyShift action_76
action_107 (52) = happyShift action_77
action_107 (54) = happyShift action_78
action_107 (56) = happyShift action_79
action_107 (97) = happyShift action_2
action_107 (98) = happyShift action_81
action_107 (99) = happyShift action_82
action_107 (100) = happyShift action_83
action_107 (101) = happyShift action_25
action_107 (4) = happyGoto action_52
action_107 (5) = happyGoto action_53
action_107 (6) = happyGoto action_54
action_107 (7) = happyGoto action_55
action_107 (8) = happyGoto action_56
action_107 (23) = happyGoto action_57
action_107 (24) = happyGoto action_58
action_107 (25) = happyGoto action_59
action_107 (26) = happyGoto action_60
action_107 (27) = happyGoto action_61
action_107 (28) = happyGoto action_62
action_107 (29) = happyGoto action_63
action_107 (30) = happyGoto action_64
action_107 (31) = happyGoto action_65
action_107 (32) = happyGoto action_66
action_107 (33) = happyGoto action_154
action_107 (37) = happyGoto action_70
action_107 (39) = happyGoto action_72
action_107 (40) = happyGoto action_73
action_107 (41) = happyGoto action_74
action_107 (42) = happyGoto action_12
action_107 (43) = happyGoto action_75
action_107 (44) = happyGoto action_14
action_107 _ = happyFail

action_108 (47) = happyShift action_76
action_108 (52) = happyShift action_77
action_108 (54) = happyShift action_78
action_108 (56) = happyShift action_79
action_108 (97) = happyShift action_2
action_108 (98) = happyShift action_81
action_108 (99) = happyShift action_82
action_108 (100) = happyShift action_83
action_108 (101) = happyShift action_25
action_108 (4) = happyGoto action_52
action_108 (5) = happyGoto action_53
action_108 (6) = happyGoto action_54
action_108 (7) = happyGoto action_55
action_108 (8) = happyGoto action_56
action_108 (23) = happyGoto action_57
action_108 (24) = happyGoto action_58
action_108 (25) = happyGoto action_59
action_108 (26) = happyGoto action_60
action_108 (27) = happyGoto action_61
action_108 (28) = happyGoto action_62
action_108 (29) = happyGoto action_63
action_108 (30) = happyGoto action_64
action_108 (31) = happyGoto action_65
action_108 (32) = happyGoto action_153
action_108 (37) = happyGoto action_70
action_108 (39) = happyGoto action_72
action_108 (40) = happyGoto action_73
action_108 (41) = happyGoto action_74
action_108 (42) = happyGoto action_12
action_108 (43) = happyGoto action_75
action_108 (44) = happyGoto action_14
action_108 _ = happyFail

action_109 (47) = happyShift action_76
action_109 (52) = happyShift action_77
action_109 (54) = happyShift action_78
action_109 (56) = happyShift action_79
action_109 (97) = happyShift action_2
action_109 (98) = happyShift action_81
action_109 (99) = happyShift action_82
action_109 (100) = happyShift action_83
action_109 (101) = happyShift action_25
action_109 (4) = happyGoto action_52
action_109 (5) = happyGoto action_53
action_109 (6) = happyGoto action_54
action_109 (7) = happyGoto action_55
action_109 (8) = happyGoto action_56
action_109 (23) = happyGoto action_57
action_109 (24) = happyGoto action_58
action_109 (25) = happyGoto action_59
action_109 (26) = happyGoto action_60
action_109 (27) = happyGoto action_61
action_109 (28) = happyGoto action_62
action_109 (29) = happyGoto action_63
action_109 (30) = happyGoto action_64
action_109 (31) = happyGoto action_65
action_109 (37) = happyGoto action_70
action_109 (39) = happyGoto action_152
action_109 (40) = happyGoto action_73
action_109 (41) = happyGoto action_74
action_109 (42) = happyGoto action_12
action_109 (43) = happyGoto action_75
action_109 (44) = happyGoto action_14
action_109 _ = happyFail

action_110 (47) = happyShift action_76
action_110 (52) = happyShift action_77
action_110 (54) = happyShift action_78
action_110 (56) = happyShift action_79
action_110 (97) = happyShift action_2
action_110 (98) = happyShift action_81
action_110 (99) = happyShift action_82
action_110 (100) = happyShift action_83
action_110 (101) = happyShift action_25
action_110 (4) = happyGoto action_52
action_110 (5) = happyGoto action_53
action_110 (6) = happyGoto action_54
action_110 (7) = happyGoto action_55
action_110 (8) = happyGoto action_56
action_110 (23) = happyGoto action_57
action_110 (24) = happyGoto action_58
action_110 (25) = happyGoto action_59
action_110 (26) = happyGoto action_60
action_110 (27) = happyGoto action_61
action_110 (28) = happyGoto action_62
action_110 (29) = happyGoto action_63
action_110 (30) = happyGoto action_151
action_110 (37) = happyGoto action_70
action_110 (42) = happyGoto action_12
action_110 (43) = happyGoto action_75
action_110 (44) = happyGoto action_14
action_110 _ = happyFail

action_111 (47) = happyShift action_76
action_111 (52) = happyShift action_77
action_111 (54) = happyShift action_78
action_111 (56) = happyShift action_79
action_111 (97) = happyShift action_2
action_111 (98) = happyShift action_81
action_111 (99) = happyShift action_82
action_111 (100) = happyShift action_83
action_111 (101) = happyShift action_25
action_111 (4) = happyGoto action_52
action_111 (5) = happyGoto action_53
action_111 (6) = happyGoto action_54
action_111 (7) = happyGoto action_55
action_111 (8) = happyGoto action_56
action_111 (23) = happyGoto action_57
action_111 (24) = happyGoto action_58
action_111 (25) = happyGoto action_59
action_111 (26) = happyGoto action_60
action_111 (27) = happyGoto action_61
action_111 (28) = happyGoto action_62
action_111 (29) = happyGoto action_63
action_111 (30) = happyGoto action_150
action_111 (37) = happyGoto action_70
action_111 (42) = happyGoto action_12
action_111 (43) = happyGoto action_75
action_111 (44) = happyGoto action_14
action_111 _ = happyFail

action_112 (47) = happyShift action_76
action_112 (52) = happyShift action_77
action_112 (54) = happyShift action_78
action_112 (56) = happyShift action_79
action_112 (97) = happyShift action_2
action_112 (98) = happyShift action_81
action_112 (99) = happyShift action_82
action_112 (100) = happyShift action_83
action_112 (101) = happyShift action_25
action_112 (4) = happyGoto action_52
action_112 (5) = happyGoto action_53
action_112 (6) = happyGoto action_54
action_112 (7) = happyGoto action_55
action_112 (8) = happyGoto action_56
action_112 (23) = happyGoto action_57
action_112 (24) = happyGoto action_58
action_112 (25) = happyGoto action_59
action_112 (26) = happyGoto action_60
action_112 (27) = happyGoto action_61
action_112 (28) = happyGoto action_62
action_112 (29) = happyGoto action_149
action_112 (37) = happyGoto action_70
action_112 (42) = happyGoto action_12
action_112 (43) = happyGoto action_75
action_112 (44) = happyGoto action_14
action_112 _ = happyFail

action_113 (47) = happyShift action_76
action_113 (52) = happyShift action_77
action_113 (54) = happyShift action_78
action_113 (56) = happyShift action_79
action_113 (97) = happyShift action_2
action_113 (98) = happyShift action_81
action_113 (99) = happyShift action_82
action_113 (100) = happyShift action_83
action_113 (101) = happyShift action_25
action_113 (4) = happyGoto action_52
action_113 (5) = happyGoto action_53
action_113 (6) = happyGoto action_54
action_113 (7) = happyGoto action_55
action_113 (8) = happyGoto action_56
action_113 (23) = happyGoto action_57
action_113 (24) = happyGoto action_58
action_113 (25) = happyGoto action_59
action_113 (26) = happyGoto action_60
action_113 (27) = happyGoto action_61
action_113 (28) = happyGoto action_62
action_113 (29) = happyGoto action_148
action_113 (37) = happyGoto action_70
action_113 (42) = happyGoto action_12
action_113 (43) = happyGoto action_75
action_113 (44) = happyGoto action_14
action_113 _ = happyFail

action_114 (47) = happyShift action_76
action_114 (52) = happyShift action_77
action_114 (54) = happyShift action_78
action_114 (56) = happyShift action_79
action_114 (97) = happyShift action_2
action_114 (98) = happyShift action_81
action_114 (99) = happyShift action_82
action_114 (100) = happyShift action_83
action_114 (101) = happyShift action_25
action_114 (4) = happyGoto action_52
action_114 (5) = happyGoto action_53
action_114 (6) = happyGoto action_54
action_114 (7) = happyGoto action_55
action_114 (8) = happyGoto action_56
action_114 (23) = happyGoto action_57
action_114 (24) = happyGoto action_58
action_114 (25) = happyGoto action_59
action_114 (26) = happyGoto action_60
action_114 (27) = happyGoto action_61
action_114 (28) = happyGoto action_62
action_114 (29) = happyGoto action_147
action_114 (37) = happyGoto action_70
action_114 (42) = happyGoto action_12
action_114 (43) = happyGoto action_75
action_114 (44) = happyGoto action_14
action_114 _ = happyFail

action_115 (47) = happyShift action_76
action_115 (52) = happyShift action_77
action_115 (54) = happyShift action_78
action_115 (56) = happyShift action_79
action_115 (97) = happyShift action_2
action_115 (98) = happyShift action_81
action_115 (99) = happyShift action_82
action_115 (100) = happyShift action_83
action_115 (101) = happyShift action_25
action_115 (4) = happyGoto action_52
action_115 (5) = happyGoto action_53
action_115 (6) = happyGoto action_54
action_115 (7) = happyGoto action_55
action_115 (8) = happyGoto action_56
action_115 (23) = happyGoto action_57
action_115 (24) = happyGoto action_58
action_115 (25) = happyGoto action_59
action_115 (26) = happyGoto action_60
action_115 (27) = happyGoto action_61
action_115 (28) = happyGoto action_62
action_115 (29) = happyGoto action_146
action_115 (37) = happyGoto action_70
action_115 (42) = happyGoto action_12
action_115 (43) = happyGoto action_75
action_115 (44) = happyGoto action_14
action_115 _ = happyFail

action_116 (47) = happyShift action_76
action_116 (52) = happyShift action_77
action_116 (54) = happyShift action_78
action_116 (56) = happyShift action_79
action_116 (97) = happyShift action_2
action_116 (98) = happyShift action_81
action_116 (99) = happyShift action_82
action_116 (100) = happyShift action_83
action_116 (101) = happyShift action_25
action_116 (4) = happyGoto action_52
action_116 (5) = happyGoto action_53
action_116 (6) = happyGoto action_54
action_116 (7) = happyGoto action_55
action_116 (8) = happyGoto action_56
action_116 (23) = happyGoto action_57
action_116 (24) = happyGoto action_58
action_116 (25) = happyGoto action_59
action_116 (26) = happyGoto action_60
action_116 (27) = happyGoto action_61
action_116 (28) = happyGoto action_145
action_116 (37) = happyGoto action_70
action_116 (42) = happyGoto action_12
action_116 (43) = happyGoto action_75
action_116 (44) = happyGoto action_14
action_116 _ = happyFail

action_117 (47) = happyShift action_76
action_117 (52) = happyShift action_77
action_117 (54) = happyShift action_78
action_117 (56) = happyShift action_79
action_117 (97) = happyShift action_2
action_117 (98) = happyShift action_81
action_117 (99) = happyShift action_82
action_117 (100) = happyShift action_83
action_117 (101) = happyShift action_25
action_117 (4) = happyGoto action_52
action_117 (5) = happyGoto action_53
action_117 (6) = happyGoto action_54
action_117 (7) = happyGoto action_55
action_117 (8) = happyGoto action_56
action_117 (23) = happyGoto action_57
action_117 (24) = happyGoto action_58
action_117 (25) = happyGoto action_59
action_117 (26) = happyGoto action_60
action_117 (27) = happyGoto action_144
action_117 (37) = happyGoto action_70
action_117 (42) = happyGoto action_12
action_117 (43) = happyGoto action_75
action_117 (44) = happyGoto action_14
action_117 _ = happyFail

action_118 (47) = happyShift action_76
action_118 (52) = happyShift action_77
action_118 (54) = happyShift action_78
action_118 (56) = happyShift action_79
action_118 (97) = happyShift action_2
action_118 (98) = happyShift action_81
action_118 (99) = happyShift action_82
action_118 (100) = happyShift action_83
action_118 (101) = happyShift action_25
action_118 (4) = happyGoto action_52
action_118 (5) = happyGoto action_53
action_118 (6) = happyGoto action_54
action_118 (7) = happyGoto action_55
action_118 (8) = happyGoto action_56
action_118 (23) = happyGoto action_57
action_118 (24) = happyGoto action_58
action_118 (25) = happyGoto action_59
action_118 (26) = happyGoto action_60
action_118 (27) = happyGoto action_143
action_118 (37) = happyGoto action_70
action_118 (42) = happyGoto action_12
action_118 (43) = happyGoto action_75
action_118 (44) = happyGoto action_14
action_118 _ = happyFail

action_119 (47) = happyShift action_76
action_119 (52) = happyShift action_77
action_119 (54) = happyShift action_78
action_119 (56) = happyShift action_79
action_119 (97) = happyShift action_2
action_119 (98) = happyShift action_81
action_119 (99) = happyShift action_82
action_119 (100) = happyShift action_83
action_119 (101) = happyShift action_25
action_119 (4) = happyGoto action_52
action_119 (5) = happyGoto action_53
action_119 (6) = happyGoto action_54
action_119 (7) = happyGoto action_55
action_119 (8) = happyGoto action_56
action_119 (23) = happyGoto action_57
action_119 (24) = happyGoto action_58
action_119 (25) = happyGoto action_59
action_119 (26) = happyGoto action_60
action_119 (27) = happyGoto action_61
action_119 (28) = happyGoto action_62
action_119 (29) = happyGoto action_142
action_119 (37) = happyGoto action_70
action_119 (42) = happyGoto action_12
action_119 (43) = happyGoto action_75
action_119 (44) = happyGoto action_14
action_119 _ = happyFail

action_120 (47) = happyShift action_76
action_120 (52) = happyShift action_77
action_120 (54) = happyShift action_78
action_120 (56) = happyShift action_79
action_120 (97) = happyShift action_2
action_120 (98) = happyShift action_81
action_120 (99) = happyShift action_82
action_120 (100) = happyShift action_83
action_120 (101) = happyShift action_25
action_120 (4) = happyGoto action_52
action_120 (5) = happyGoto action_53
action_120 (6) = happyGoto action_54
action_120 (7) = happyGoto action_55
action_120 (8) = happyGoto action_56
action_120 (23) = happyGoto action_57
action_120 (24) = happyGoto action_58
action_120 (25) = happyGoto action_59
action_120 (26) = happyGoto action_141
action_120 (37) = happyGoto action_70
action_120 (42) = happyGoto action_12
action_120 (43) = happyGoto action_75
action_120 (44) = happyGoto action_14
action_120 _ = happyFail

action_121 (47) = happyShift action_76
action_121 (52) = happyShift action_77
action_121 (54) = happyShift action_78
action_121 (56) = happyShift action_79
action_121 (97) = happyShift action_2
action_121 (98) = happyShift action_81
action_121 (99) = happyShift action_82
action_121 (100) = happyShift action_83
action_121 (101) = happyShift action_25
action_121 (4) = happyGoto action_52
action_121 (5) = happyGoto action_53
action_121 (6) = happyGoto action_54
action_121 (7) = happyGoto action_55
action_121 (8) = happyGoto action_56
action_121 (23) = happyGoto action_57
action_121 (24) = happyGoto action_58
action_121 (25) = happyGoto action_59
action_121 (26) = happyGoto action_140
action_121 (37) = happyGoto action_70
action_121 (42) = happyGoto action_12
action_121 (43) = happyGoto action_75
action_121 (44) = happyGoto action_14
action_121 _ = happyFail

action_122 (47) = happyShift action_76
action_122 (52) = happyShift action_77
action_122 (54) = happyShift action_78
action_122 (56) = happyShift action_79
action_122 (97) = happyShift action_2
action_122 (98) = happyShift action_81
action_122 (99) = happyShift action_82
action_122 (100) = happyShift action_83
action_122 (101) = happyShift action_25
action_122 (4) = happyGoto action_52
action_122 (5) = happyGoto action_53
action_122 (6) = happyGoto action_54
action_122 (7) = happyGoto action_55
action_122 (8) = happyGoto action_56
action_122 (23) = happyGoto action_57
action_122 (24) = happyGoto action_58
action_122 (25) = happyGoto action_59
action_122 (26) = happyGoto action_139
action_122 (37) = happyGoto action_70
action_122 (42) = happyGoto action_12
action_122 (43) = happyGoto action_75
action_122 (44) = happyGoto action_14
action_122 _ = happyFail

action_123 (52) = happyShift action_77
action_123 (97) = happyShift action_2
action_123 (98) = happyShift action_81
action_123 (99) = happyShift action_82
action_123 (100) = happyShift action_83
action_123 (101) = happyShift action_25
action_123 (4) = happyGoto action_52
action_123 (5) = happyGoto action_53
action_123 (6) = happyGoto action_54
action_123 (7) = happyGoto action_55
action_123 (8) = happyGoto action_56
action_123 (23) = happyGoto action_57
action_123 (24) = happyGoto action_138
action_123 (37) = happyGoto action_70
action_123 (42) = happyGoto action_12
action_123 (43) = happyGoto action_75
action_123 (44) = happyGoto action_14
action_123 _ = happyFail

action_124 (52) = happyShift action_77
action_124 (97) = happyShift action_2
action_124 (98) = happyShift action_81
action_124 (99) = happyShift action_82
action_124 (100) = happyShift action_83
action_124 (101) = happyShift action_25
action_124 (4) = happyGoto action_52
action_124 (5) = happyGoto action_53
action_124 (6) = happyGoto action_54
action_124 (7) = happyGoto action_55
action_124 (8) = happyGoto action_56
action_124 (23) = happyGoto action_57
action_124 (24) = happyGoto action_137
action_124 (37) = happyGoto action_70
action_124 (42) = happyGoto action_12
action_124 (43) = happyGoto action_75
action_124 (44) = happyGoto action_14
action_124 _ = happyFail

action_125 _ = happyReduce_59

action_126 (47) = happyShift action_76
action_126 (52) = happyShift action_77
action_126 (54) = happyShift action_78
action_126 (56) = happyShift action_79
action_126 (89) = happyShift action_80
action_126 (97) = happyShift action_2
action_126 (98) = happyShift action_81
action_126 (99) = happyShift action_82
action_126 (100) = happyShift action_83
action_126 (101) = happyShift action_25
action_126 (4) = happyGoto action_52
action_126 (5) = happyGoto action_53
action_126 (6) = happyGoto action_54
action_126 (7) = happyGoto action_55
action_126 (8) = happyGoto action_56
action_126 (23) = happyGoto action_57
action_126 (24) = happyGoto action_58
action_126 (25) = happyGoto action_59
action_126 (26) = happyGoto action_60
action_126 (27) = happyGoto action_61
action_126 (28) = happyGoto action_62
action_126 (29) = happyGoto action_63
action_126 (30) = happyGoto action_64
action_126 (31) = happyGoto action_65
action_126 (32) = happyGoto action_66
action_126 (33) = happyGoto action_67
action_126 (34) = happyGoto action_68
action_126 (35) = happyGoto action_69
action_126 (36) = happyGoto action_135
action_126 (37) = happyGoto action_70
action_126 (38) = happyGoto action_136
action_126 (39) = happyGoto action_72
action_126 (40) = happyGoto action_73
action_126 (41) = happyGoto action_74
action_126 (42) = happyGoto action_12
action_126 (43) = happyGoto action_75
action_126 (44) = happyGoto action_14
action_126 _ = happyReduce_94

action_127 (47) = happyShift action_76
action_127 (52) = happyShift action_77
action_127 (54) = happyShift action_78
action_127 (56) = happyShift action_79
action_127 (89) = happyShift action_80
action_127 (97) = happyShift action_2
action_127 (98) = happyShift action_81
action_127 (99) = happyShift action_82
action_127 (100) = happyShift action_83
action_127 (101) = happyShift action_25
action_127 (4) = happyGoto action_52
action_127 (5) = happyGoto action_53
action_127 (6) = happyGoto action_54
action_127 (7) = happyGoto action_55
action_127 (8) = happyGoto action_56
action_127 (23) = happyGoto action_57
action_127 (24) = happyGoto action_58
action_127 (25) = happyGoto action_59
action_127 (26) = happyGoto action_60
action_127 (27) = happyGoto action_61
action_127 (28) = happyGoto action_62
action_127 (29) = happyGoto action_63
action_127 (30) = happyGoto action_64
action_127 (31) = happyGoto action_65
action_127 (32) = happyGoto action_66
action_127 (33) = happyGoto action_67
action_127 (34) = happyGoto action_68
action_127 (35) = happyGoto action_69
action_127 (37) = happyGoto action_70
action_127 (38) = happyGoto action_134
action_127 (39) = happyGoto action_72
action_127 (40) = happyGoto action_73
action_127 (41) = happyGoto action_74
action_127 (42) = happyGoto action_12
action_127 (43) = happyGoto action_75
action_127 (44) = happyGoto action_14
action_127 _ = happyFail

action_128 _ = happyReduce_98

action_129 _ = happyReduce_27

action_130 (66) = happyShift action_133
action_130 _ = happyFail

action_131 (50) = happyShift action_33
action_131 (101) = happyShift action_25
action_131 (8) = happyGoto action_95
action_131 _ = happyFail

action_132 _ = happyReduce_21

action_133 _ = happyReduce_23

action_134 (77) = happyShift action_167
action_134 _ = happyFail

action_135 (53) = happyShift action_166
action_135 _ = happyFail

action_136 (58) = happyShift action_165
action_136 _ = happyReduce_95

action_137 _ = happyReduce_57

action_138 _ = happyReduce_58

action_139 _ = happyReduce_66

action_140 _ = happyReduce_65

action_141 _ = happyReduce_67

action_142 (68) = happyShift action_116
action_142 _ = happyReduce_73

action_143 (49) = happyShift action_120
action_143 (54) = happyShift action_121
action_143 (63) = happyShift action_122
action_143 _ = happyReduce_70

action_144 (49) = happyShift action_120
action_144 (54) = happyShift action_121
action_144 (63) = happyShift action_122
action_144 _ = happyReduce_69

action_145 (55) = happyShift action_117
action_145 (59) = happyShift action_118
action_145 _ = happyReduce_72

action_146 (68) = happyShift action_116
action_146 _ = happyReduce_78

action_147 (68) = happyShift action_116
action_147 _ = happyReduce_76

action_148 (68) = happyShift action_116
action_148 _ = happyReduce_77

action_149 (68) = happyShift action_116
action_149 _ = happyReduce_75

action_150 (67) = happyShift action_112
action_150 (69) = happyShift action_113
action_150 (72) = happyShift action_114
action_150 (73) = happyShift action_115
action_150 _ = happyReduce_80

action_151 (67) = happyShift action_112
action_151 (69) = happyShift action_113
action_151 (72) = happyShift action_114
action_151 (73) = happyShift action_115
action_151 _ = happyReduce_81

action_152 _ = happyReduce_83

action_153 (51) = happyShift action_109
action_153 _ = happyReduce_85

action_154 (64) = happyShift action_164
action_154 (95) = happyShift action_108
action_154 _ = happyFail

action_155 _ = happyReduce_87

action_156 _ = happyReduce_89

action_157 _ = happyReduce_88

action_158 _ = happyReduce_52

action_159 _ = happyReduce_34

action_160 _ = happyReduce_15

action_161 (22) = happyGoto action_163
action_161 _ = happyReduce_46

action_162 _ = happyReduce_19

action_163 (47) = happyShift action_76
action_163 (52) = happyShift action_77
action_163 (54) = happyShift action_78
action_163 (56) = happyShift action_79
action_163 (78) = happyShift action_16
action_163 (79) = happyShift action_17
action_163 (80) = happyShift action_177
action_163 (81) = happyShift action_18
action_163 (83) = happyShift action_178
action_163 (84) = happyShift action_179
action_163 (86) = happyShift action_20
action_163 (87) = happyShift action_180
action_163 (88) = happyShift action_21
action_163 (89) = happyShift action_80
action_163 (90) = happyShift action_22
action_163 (92) = happyShift action_24
action_163 (93) = happyShift action_181
action_163 (94) = happyShift action_182
action_163 (96) = happyShift action_183
action_163 (97) = happyShift action_2
action_163 (98) = happyShift action_81
action_163 (99) = happyShift action_82
action_163 (100) = happyShift action_83
action_163 (101) = happyShift action_25
action_163 (4) = happyGoto action_52
action_163 (5) = happyGoto action_53
action_163 (6) = happyGoto action_54
action_163 (7) = happyGoto action_55
action_163 (8) = happyGoto action_56
action_163 (14) = happyGoto action_170
action_163 (15) = happyGoto action_171
action_163 (17) = happyGoto action_10
action_163 (19) = happyGoto action_172
action_163 (21) = happyGoto action_173
action_163 (23) = happyGoto action_57
action_163 (24) = happyGoto action_58
action_163 (25) = happyGoto action_59
action_163 (26) = happyGoto action_60
action_163 (27) = happyGoto action_61
action_163 (28) = happyGoto action_62
action_163 (29) = happyGoto action_63
action_163 (30) = happyGoto action_64
action_163 (31) = happyGoto action_65
action_163 (32) = happyGoto action_66
action_163 (33) = happyGoto action_67
action_163 (34) = happyGoto action_68
action_163 (35) = happyGoto action_69
action_163 (37) = happyGoto action_70
action_163 (38) = happyGoto action_174
action_163 (39) = happyGoto action_72
action_163 (40) = happyGoto action_73
action_163 (41) = happyGoto action_74
action_163 (42) = happyGoto action_12
action_163 (43) = happyGoto action_175
action_163 (44) = happyGoto action_14
action_163 (46) = happyGoto action_176
action_163 _ = happyFail

action_164 (47) = happyShift action_76
action_164 (52) = happyShift action_77
action_164 (54) = happyShift action_78
action_164 (56) = happyShift action_79
action_164 (97) = happyShift action_2
action_164 (98) = happyShift action_81
action_164 (99) = happyShift action_82
action_164 (100) = happyShift action_83
action_164 (101) = happyShift action_25
action_164 (4) = happyGoto action_52
action_164 (5) = happyGoto action_53
action_164 (6) = happyGoto action_54
action_164 (7) = happyGoto action_55
action_164 (8) = happyGoto action_56
action_164 (23) = happyGoto action_57
action_164 (24) = happyGoto action_58
action_164 (25) = happyGoto action_59
action_164 (26) = happyGoto action_60
action_164 (27) = happyGoto action_61
action_164 (28) = happyGoto action_62
action_164 (29) = happyGoto action_63
action_164 (30) = happyGoto action_64
action_164 (31) = happyGoto action_65
action_164 (32) = happyGoto action_66
action_164 (33) = happyGoto action_169
action_164 (37) = happyGoto action_70
action_164 (39) = happyGoto action_72
action_164 (40) = happyGoto action_73
action_164 (41) = happyGoto action_74
action_164 (42) = happyGoto action_12
action_164 (43) = happyGoto action_75
action_164 (44) = happyGoto action_14
action_164 _ = happyFail

action_165 (47) = happyShift action_76
action_165 (52) = happyShift action_77
action_165 (54) = happyShift action_78
action_165 (56) = happyShift action_79
action_165 (89) = happyShift action_80
action_165 (97) = happyShift action_2
action_165 (98) = happyShift action_81
action_165 (99) = happyShift action_82
action_165 (100) = happyShift action_83
action_165 (101) = happyShift action_25
action_165 (4) = happyGoto action_52
action_165 (5) = happyGoto action_53
action_165 (6) = happyGoto action_54
action_165 (7) = happyGoto action_55
action_165 (8) = happyGoto action_56
action_165 (23) = happyGoto action_57
action_165 (24) = happyGoto action_58
action_165 (25) = happyGoto action_59
action_165 (26) = happyGoto action_60
action_165 (27) = happyGoto action_61
action_165 (28) = happyGoto action_62
action_165 (29) = happyGoto action_63
action_165 (30) = happyGoto action_64
action_165 (31) = happyGoto action_65
action_165 (32) = happyGoto action_66
action_165 (33) = happyGoto action_67
action_165 (34) = happyGoto action_68
action_165 (35) = happyGoto action_69
action_165 (36) = happyGoto action_168
action_165 (37) = happyGoto action_70
action_165 (38) = happyGoto action_136
action_165 (39) = happyGoto action_72
action_165 (40) = happyGoto action_73
action_165 (41) = happyGoto action_74
action_165 (42) = happyGoto action_12
action_165 (43) = happyGoto action_75
action_165 (44) = happyGoto action_14
action_165 _ = happyReduce_94

action_166 _ = happyReduce_55

action_167 _ = happyReduce_54

action_168 _ = happyReduce_96

action_169 (95) = happyShift action_108
action_169 _ = happyReduce_90

action_170 (66) = happyShift action_194
action_170 _ = happyFail

action_171 (66) = happyShift action_193
action_171 _ = happyFail

action_172 (66) = happyShift action_192
action_172 _ = happyFail

action_173 _ = happyReduce_47

action_174 (66) = happyShift action_191
action_174 _ = happyFail

action_175 (50) = happyReduce_114
action_175 (101) = happyReduce_114
action_175 _ = happyReduce_53

action_176 (50) = happyShift action_33
action_176 (101) = happyShift action_25
action_176 (8) = happyGoto action_190
action_176 _ = happyFail

action_177 (47) = happyShift action_76
action_177 (52) = happyShift action_77
action_177 (54) = happyShift action_78
action_177 (56) = happyShift action_79
action_177 (78) = happyShift action_16
action_177 (79) = happyShift action_17
action_177 (80) = happyShift action_177
action_177 (81) = happyShift action_18
action_177 (83) = happyShift action_178
action_177 (84) = happyShift action_179
action_177 (86) = happyShift action_20
action_177 (87) = happyShift action_180
action_177 (88) = happyShift action_21
action_177 (89) = happyShift action_80
action_177 (90) = happyShift action_22
action_177 (92) = happyShift action_24
action_177 (93) = happyShift action_181
action_177 (94) = happyShift action_182
action_177 (97) = happyShift action_2
action_177 (98) = happyShift action_81
action_177 (99) = happyShift action_82
action_177 (100) = happyShift action_83
action_177 (101) = happyShift action_25
action_177 (4) = happyGoto action_52
action_177 (5) = happyGoto action_53
action_177 (6) = happyGoto action_54
action_177 (7) = happyGoto action_55
action_177 (8) = happyGoto action_56
action_177 (14) = happyGoto action_170
action_177 (15) = happyGoto action_171
action_177 (17) = happyGoto action_10
action_177 (19) = happyGoto action_172
action_177 (21) = happyGoto action_189
action_177 (23) = happyGoto action_57
action_177 (24) = happyGoto action_58
action_177 (25) = happyGoto action_59
action_177 (26) = happyGoto action_60
action_177 (27) = happyGoto action_61
action_177 (28) = happyGoto action_62
action_177 (29) = happyGoto action_63
action_177 (30) = happyGoto action_64
action_177 (31) = happyGoto action_65
action_177 (32) = happyGoto action_66
action_177 (33) = happyGoto action_67
action_177 (34) = happyGoto action_68
action_177 (35) = happyGoto action_69
action_177 (37) = happyGoto action_70
action_177 (38) = happyGoto action_174
action_177 (39) = happyGoto action_72
action_177 (40) = happyGoto action_73
action_177 (41) = happyGoto action_74
action_177 (42) = happyGoto action_12
action_177 (43) = happyGoto action_175
action_177 (44) = happyGoto action_14
action_177 (46) = happyGoto action_176
action_177 _ = happyFail

action_178 (52) = happyShift action_188
action_178 _ = happyFail

action_179 (52) = happyShift action_187
action_179 _ = happyFail

action_180 (47) = happyShift action_76
action_180 (52) = happyShift action_77
action_180 (54) = happyShift action_78
action_180 (56) = happyShift action_79
action_180 (89) = happyShift action_80
action_180 (97) = happyShift action_2
action_180 (98) = happyShift action_81
action_180 (99) = happyShift action_82
action_180 (100) = happyShift action_83
action_180 (101) = happyShift action_25
action_180 (4) = happyGoto action_52
action_180 (5) = happyGoto action_53
action_180 (6) = happyGoto action_54
action_180 (7) = happyGoto action_55
action_180 (8) = happyGoto action_56
action_180 (23) = happyGoto action_57
action_180 (24) = happyGoto action_58
action_180 (25) = happyGoto action_59
action_180 (26) = happyGoto action_60
action_180 (27) = happyGoto action_61
action_180 (28) = happyGoto action_62
action_180 (29) = happyGoto action_63
action_180 (30) = happyGoto action_64
action_180 (31) = happyGoto action_65
action_180 (32) = happyGoto action_66
action_180 (33) = happyGoto action_67
action_180 (34) = happyGoto action_68
action_180 (35) = happyGoto action_69
action_180 (37) = happyGoto action_70
action_180 (38) = happyGoto action_186
action_180 (39) = happyGoto action_72
action_180 (40) = happyGoto action_73
action_180 (41) = happyGoto action_74
action_180 (42) = happyGoto action_12
action_180 (43) = happyGoto action_75
action_180 (44) = happyGoto action_14
action_180 _ = happyFail

action_181 (52) = happyShift action_185
action_181 _ = happyFail

action_182 (22) = happyGoto action_184
action_182 _ = happyReduce_46

action_183 _ = happyReduce_16

action_184 (47) = happyShift action_76
action_184 (52) = happyShift action_77
action_184 (54) = happyShift action_78
action_184 (56) = happyShift action_79
action_184 (78) = happyShift action_16
action_184 (79) = happyShift action_17
action_184 (80) = happyShift action_177
action_184 (81) = happyShift action_18
action_184 (83) = happyShift action_178
action_184 (84) = happyShift action_179
action_184 (86) = happyShift action_20
action_184 (87) = happyShift action_180
action_184 (88) = happyShift action_21
action_184 (89) = happyShift action_80
action_184 (90) = happyShift action_22
action_184 (92) = happyShift action_24
action_184 (93) = happyShift action_181
action_184 (94) = happyShift action_182
action_184 (96) = happyShift action_200
action_184 (97) = happyShift action_2
action_184 (98) = happyShift action_81
action_184 (99) = happyShift action_82
action_184 (100) = happyShift action_83
action_184 (101) = happyShift action_25
action_184 (4) = happyGoto action_52
action_184 (5) = happyGoto action_53
action_184 (6) = happyGoto action_54
action_184 (7) = happyGoto action_55
action_184 (8) = happyGoto action_56
action_184 (14) = happyGoto action_170
action_184 (15) = happyGoto action_171
action_184 (17) = happyGoto action_10
action_184 (19) = happyGoto action_172
action_184 (21) = happyGoto action_173
action_184 (23) = happyGoto action_57
action_184 (24) = happyGoto action_58
action_184 (25) = happyGoto action_59
action_184 (26) = happyGoto action_60
action_184 (27) = happyGoto action_61
action_184 (28) = happyGoto action_62
action_184 (29) = happyGoto action_63
action_184 (30) = happyGoto action_64
action_184 (31) = happyGoto action_65
action_184 (32) = happyGoto action_66
action_184 (33) = happyGoto action_67
action_184 (34) = happyGoto action_68
action_184 (35) = happyGoto action_69
action_184 (37) = happyGoto action_70
action_184 (38) = happyGoto action_174
action_184 (39) = happyGoto action_72
action_184 (40) = happyGoto action_73
action_184 (41) = happyGoto action_74
action_184 (42) = happyGoto action_12
action_184 (43) = happyGoto action_175
action_184 (44) = happyGoto action_14
action_184 (46) = happyGoto action_176
action_184 _ = happyFail

action_185 (47) = happyShift action_76
action_185 (52) = happyShift action_77
action_185 (54) = happyShift action_78
action_185 (56) = happyShift action_79
action_185 (89) = happyShift action_80
action_185 (97) = happyShift action_2
action_185 (98) = happyShift action_81
action_185 (99) = happyShift action_82
action_185 (100) = happyShift action_83
action_185 (101) = happyShift action_25
action_185 (4) = happyGoto action_52
action_185 (5) = happyGoto action_53
action_185 (6) = happyGoto action_54
action_185 (7) = happyGoto action_55
action_185 (8) = happyGoto action_56
action_185 (23) = happyGoto action_57
action_185 (24) = happyGoto action_58
action_185 (25) = happyGoto action_59
action_185 (26) = happyGoto action_60
action_185 (27) = happyGoto action_61
action_185 (28) = happyGoto action_62
action_185 (29) = happyGoto action_63
action_185 (30) = happyGoto action_64
action_185 (31) = happyGoto action_65
action_185 (32) = happyGoto action_66
action_185 (33) = happyGoto action_67
action_185 (34) = happyGoto action_68
action_185 (35) = happyGoto action_69
action_185 (37) = happyGoto action_70
action_185 (38) = happyGoto action_199
action_185 (39) = happyGoto action_72
action_185 (40) = happyGoto action_73
action_185 (41) = happyGoto action_74
action_185 (42) = happyGoto action_12
action_185 (43) = happyGoto action_75
action_185 (44) = happyGoto action_14
action_185 _ = happyFail

action_186 (66) = happyShift action_198
action_186 _ = happyFail

action_187 (47) = happyShift action_76
action_187 (52) = happyShift action_77
action_187 (54) = happyShift action_78
action_187 (56) = happyShift action_79
action_187 (89) = happyShift action_80
action_187 (97) = happyShift action_2
action_187 (98) = happyShift action_81
action_187 (99) = happyShift action_82
action_187 (100) = happyShift action_83
action_187 (101) = happyShift action_25
action_187 (4) = happyGoto action_52
action_187 (5) = happyGoto action_53
action_187 (6) = happyGoto action_54
action_187 (7) = happyGoto action_55
action_187 (8) = happyGoto action_56
action_187 (23) = happyGoto action_57
action_187 (24) = happyGoto action_58
action_187 (25) = happyGoto action_59
action_187 (26) = happyGoto action_60
action_187 (27) = happyGoto action_61
action_187 (28) = happyGoto action_62
action_187 (29) = happyGoto action_63
action_187 (30) = happyGoto action_64
action_187 (31) = happyGoto action_65
action_187 (32) = happyGoto action_66
action_187 (33) = happyGoto action_67
action_187 (34) = happyGoto action_68
action_187 (35) = happyGoto action_69
action_187 (37) = happyGoto action_70
action_187 (38) = happyGoto action_197
action_187 (39) = happyGoto action_72
action_187 (40) = happyGoto action_73
action_187 (41) = happyGoto action_74
action_187 (42) = happyGoto action_12
action_187 (43) = happyGoto action_75
action_187 (44) = happyGoto action_14
action_187 _ = happyFail

action_188 (78) = happyShift action_16
action_188 (79) = happyShift action_17
action_188 (81) = happyShift action_18
action_188 (86) = happyShift action_20
action_188 (92) = happyShift action_24
action_188 (101) = happyShift action_25
action_188 (8) = happyGoto action_5
action_188 (17) = happyGoto action_10
action_188 (19) = happyGoto action_196
action_188 (42) = happyGoto action_12
action_188 (43) = happyGoto action_13
action_188 (44) = happyGoto action_14
action_188 (46) = happyGoto action_176
action_188 _ = happyFail

action_189 (93) = happyShift action_195
action_189 _ = happyFail

action_190 (58) = happyShift action_43
action_190 (70) = happyShift action_44
action_190 _ = happyReduce_24

action_191 _ = happyReduce_35

action_192 _ = happyReduce_36

action_193 _ = happyReduce_43

action_194 _ = happyReduce_42

action_195 (52) = happyShift action_204
action_195 _ = happyFail

action_196 (66) = happyShift action_203
action_196 _ = happyFail

action_197 (53) = happyShift action_202
action_197 _ = happyFail

action_198 _ = happyReduce_37

action_199 (53) = happyShift action_201
action_199 _ = happyFail

action_200 _ = happyReduce_38

action_201 (47) = happyShift action_76
action_201 (52) = happyShift action_77
action_201 (54) = happyShift action_78
action_201 (56) = happyShift action_79
action_201 (78) = happyShift action_16
action_201 (79) = happyShift action_17
action_201 (80) = happyShift action_177
action_201 (81) = happyShift action_18
action_201 (83) = happyShift action_178
action_201 (84) = happyShift action_179
action_201 (86) = happyShift action_20
action_201 (87) = happyShift action_180
action_201 (88) = happyShift action_21
action_201 (89) = happyShift action_80
action_201 (90) = happyShift action_22
action_201 (92) = happyShift action_24
action_201 (93) = happyShift action_181
action_201 (94) = happyShift action_182
action_201 (97) = happyShift action_2
action_201 (98) = happyShift action_81
action_201 (99) = happyShift action_82
action_201 (100) = happyShift action_83
action_201 (101) = happyShift action_25
action_201 (4) = happyGoto action_52
action_201 (5) = happyGoto action_53
action_201 (6) = happyGoto action_54
action_201 (7) = happyGoto action_55
action_201 (8) = happyGoto action_56
action_201 (14) = happyGoto action_170
action_201 (15) = happyGoto action_171
action_201 (17) = happyGoto action_10
action_201 (19) = happyGoto action_172
action_201 (21) = happyGoto action_208
action_201 (23) = happyGoto action_57
action_201 (24) = happyGoto action_58
action_201 (25) = happyGoto action_59
action_201 (26) = happyGoto action_60
action_201 (27) = happyGoto action_61
action_201 (28) = happyGoto action_62
action_201 (29) = happyGoto action_63
action_201 (30) = happyGoto action_64
action_201 (31) = happyGoto action_65
action_201 (32) = happyGoto action_66
action_201 (33) = happyGoto action_67
action_201 (34) = happyGoto action_68
action_201 (35) = happyGoto action_69
action_201 (37) = happyGoto action_70
action_201 (38) = happyGoto action_174
action_201 (39) = happyGoto action_72
action_201 (40) = happyGoto action_73
action_201 (41) = happyGoto action_74
action_201 (42) = happyGoto action_12
action_201 (43) = happyGoto action_175
action_201 (44) = happyGoto action_14
action_201 (46) = happyGoto action_176
action_201 _ = happyFail

action_202 (47) = happyShift action_76
action_202 (52) = happyShift action_77
action_202 (54) = happyShift action_78
action_202 (56) = happyShift action_79
action_202 (78) = happyShift action_16
action_202 (79) = happyShift action_17
action_202 (80) = happyShift action_177
action_202 (81) = happyShift action_18
action_202 (83) = happyShift action_178
action_202 (84) = happyShift action_179
action_202 (86) = happyShift action_20
action_202 (87) = happyShift action_180
action_202 (88) = happyShift action_21
action_202 (89) = happyShift action_80
action_202 (90) = happyShift action_22
action_202 (92) = happyShift action_24
action_202 (93) = happyShift action_181
action_202 (94) = happyShift action_182
action_202 (97) = happyShift action_2
action_202 (98) = happyShift action_81
action_202 (99) = happyShift action_82
action_202 (100) = happyShift action_83
action_202 (101) = happyShift action_25
action_202 (4) = happyGoto action_52
action_202 (5) = happyGoto action_53
action_202 (6) = happyGoto action_54
action_202 (7) = happyGoto action_55
action_202 (8) = happyGoto action_56
action_202 (14) = happyGoto action_170
action_202 (15) = happyGoto action_171
action_202 (17) = happyGoto action_10
action_202 (19) = happyGoto action_172
action_202 (21) = happyGoto action_207
action_202 (23) = happyGoto action_57
action_202 (24) = happyGoto action_58
action_202 (25) = happyGoto action_59
action_202 (26) = happyGoto action_60
action_202 (27) = happyGoto action_61
action_202 (28) = happyGoto action_62
action_202 (29) = happyGoto action_63
action_202 (30) = happyGoto action_64
action_202 (31) = happyGoto action_65
action_202 (32) = happyGoto action_66
action_202 (33) = happyGoto action_67
action_202 (34) = happyGoto action_68
action_202 (35) = happyGoto action_69
action_202 (37) = happyGoto action_70
action_202 (38) = happyGoto action_174
action_202 (39) = happyGoto action_72
action_202 (40) = happyGoto action_73
action_202 (41) = happyGoto action_74
action_202 (42) = happyGoto action_12
action_202 (43) = happyGoto action_175
action_202 (44) = happyGoto action_14
action_202 (46) = happyGoto action_176
action_202 _ = happyFail

action_203 (47) = happyShift action_76
action_203 (52) = happyShift action_77
action_203 (54) = happyShift action_78
action_203 (56) = happyShift action_79
action_203 (89) = happyShift action_80
action_203 (97) = happyShift action_2
action_203 (98) = happyShift action_81
action_203 (99) = happyShift action_82
action_203 (100) = happyShift action_83
action_203 (101) = happyShift action_25
action_203 (4) = happyGoto action_52
action_203 (5) = happyGoto action_53
action_203 (6) = happyGoto action_54
action_203 (7) = happyGoto action_55
action_203 (8) = happyGoto action_56
action_203 (23) = happyGoto action_57
action_203 (24) = happyGoto action_58
action_203 (25) = happyGoto action_59
action_203 (26) = happyGoto action_60
action_203 (27) = happyGoto action_61
action_203 (28) = happyGoto action_62
action_203 (29) = happyGoto action_63
action_203 (30) = happyGoto action_64
action_203 (31) = happyGoto action_65
action_203 (32) = happyGoto action_66
action_203 (33) = happyGoto action_67
action_203 (34) = happyGoto action_68
action_203 (35) = happyGoto action_69
action_203 (37) = happyGoto action_70
action_203 (38) = happyGoto action_206
action_203 (39) = happyGoto action_72
action_203 (40) = happyGoto action_73
action_203 (41) = happyGoto action_74
action_203 (42) = happyGoto action_12
action_203 (43) = happyGoto action_75
action_203 (44) = happyGoto action_14
action_203 _ = happyFail

action_204 (47) = happyShift action_76
action_204 (52) = happyShift action_77
action_204 (54) = happyShift action_78
action_204 (56) = happyShift action_79
action_204 (89) = happyShift action_80
action_204 (97) = happyShift action_2
action_204 (98) = happyShift action_81
action_204 (99) = happyShift action_82
action_204 (100) = happyShift action_83
action_204 (101) = happyShift action_25
action_204 (4) = happyGoto action_52
action_204 (5) = happyGoto action_53
action_204 (6) = happyGoto action_54
action_204 (7) = happyGoto action_55
action_204 (8) = happyGoto action_56
action_204 (23) = happyGoto action_57
action_204 (24) = happyGoto action_58
action_204 (25) = happyGoto action_59
action_204 (26) = happyGoto action_60
action_204 (27) = happyGoto action_61
action_204 (28) = happyGoto action_62
action_204 (29) = happyGoto action_63
action_204 (30) = happyGoto action_64
action_204 (31) = happyGoto action_65
action_204 (32) = happyGoto action_66
action_204 (33) = happyGoto action_67
action_204 (34) = happyGoto action_68
action_204 (35) = happyGoto action_69
action_204 (37) = happyGoto action_70
action_204 (38) = happyGoto action_205
action_204 (39) = happyGoto action_72
action_204 (40) = happyGoto action_73
action_204 (41) = happyGoto action_74
action_204 (42) = happyGoto action_12
action_204 (43) = happyGoto action_75
action_204 (44) = happyGoto action_14
action_204 _ = happyFail

action_205 (53) = happyShift action_211
action_205 _ = happyFail

action_206 (66) = happyShift action_210
action_206 _ = happyFail

action_207 (82) = happyShift action_209
action_207 _ = happyReduce_44

action_208 _ = happyReduce_39

action_209 (47) = happyShift action_76
action_209 (52) = happyShift action_77
action_209 (54) = happyShift action_78
action_209 (56) = happyShift action_79
action_209 (78) = happyShift action_16
action_209 (79) = happyShift action_17
action_209 (80) = happyShift action_177
action_209 (81) = happyShift action_18
action_209 (83) = happyShift action_178
action_209 (84) = happyShift action_179
action_209 (86) = happyShift action_20
action_209 (87) = happyShift action_180
action_209 (88) = happyShift action_21
action_209 (89) = happyShift action_80
action_209 (90) = happyShift action_22
action_209 (92) = happyShift action_24
action_209 (93) = happyShift action_181
action_209 (94) = happyShift action_182
action_209 (97) = happyShift action_2
action_209 (98) = happyShift action_81
action_209 (99) = happyShift action_82
action_209 (100) = happyShift action_83
action_209 (101) = happyShift action_25
action_209 (4) = happyGoto action_52
action_209 (5) = happyGoto action_53
action_209 (6) = happyGoto action_54
action_209 (7) = happyGoto action_55
action_209 (8) = happyGoto action_56
action_209 (14) = happyGoto action_170
action_209 (15) = happyGoto action_171
action_209 (17) = happyGoto action_10
action_209 (19) = happyGoto action_172
action_209 (21) = happyGoto action_214
action_209 (23) = happyGoto action_57
action_209 (24) = happyGoto action_58
action_209 (25) = happyGoto action_59
action_209 (26) = happyGoto action_60
action_209 (27) = happyGoto action_61
action_209 (28) = happyGoto action_62
action_209 (29) = happyGoto action_63
action_209 (30) = happyGoto action_64
action_209 (31) = happyGoto action_65
action_209 (32) = happyGoto action_66
action_209 (33) = happyGoto action_67
action_209 (34) = happyGoto action_68
action_209 (35) = happyGoto action_69
action_209 (37) = happyGoto action_70
action_209 (38) = happyGoto action_174
action_209 (39) = happyGoto action_72
action_209 (40) = happyGoto action_73
action_209 (41) = happyGoto action_74
action_209 (42) = happyGoto action_12
action_209 (43) = happyGoto action_175
action_209 (44) = happyGoto action_14
action_209 (46) = happyGoto action_176
action_209 _ = happyFail

action_210 (47) = happyShift action_76
action_210 (52) = happyShift action_77
action_210 (54) = happyShift action_78
action_210 (56) = happyShift action_79
action_210 (89) = happyShift action_80
action_210 (97) = happyShift action_2
action_210 (98) = happyShift action_81
action_210 (99) = happyShift action_82
action_210 (100) = happyShift action_83
action_210 (101) = happyShift action_25
action_210 (4) = happyGoto action_52
action_210 (5) = happyGoto action_53
action_210 (6) = happyGoto action_54
action_210 (7) = happyGoto action_55
action_210 (8) = happyGoto action_56
action_210 (23) = happyGoto action_57
action_210 (24) = happyGoto action_58
action_210 (25) = happyGoto action_59
action_210 (26) = happyGoto action_60
action_210 (27) = happyGoto action_61
action_210 (28) = happyGoto action_62
action_210 (29) = happyGoto action_63
action_210 (30) = happyGoto action_64
action_210 (31) = happyGoto action_65
action_210 (32) = happyGoto action_66
action_210 (33) = happyGoto action_67
action_210 (34) = happyGoto action_68
action_210 (35) = happyGoto action_69
action_210 (37) = happyGoto action_70
action_210 (38) = happyGoto action_213
action_210 (39) = happyGoto action_72
action_210 (40) = happyGoto action_73
action_210 (41) = happyGoto action_74
action_210 (42) = happyGoto action_12
action_210 (43) = happyGoto action_75
action_210 (44) = happyGoto action_14
action_210 _ = happyFail

action_211 (66) = happyShift action_212
action_211 _ = happyFail

action_212 _ = happyReduce_40

action_213 (53) = happyShift action_215
action_213 _ = happyFail

action_214 _ = happyReduce_45

action_215 (47) = happyShift action_76
action_215 (52) = happyShift action_77
action_215 (54) = happyShift action_78
action_215 (56) = happyShift action_79
action_215 (78) = happyShift action_16
action_215 (79) = happyShift action_17
action_215 (80) = happyShift action_177
action_215 (81) = happyShift action_18
action_215 (83) = happyShift action_178
action_215 (84) = happyShift action_179
action_215 (86) = happyShift action_20
action_215 (87) = happyShift action_180
action_215 (88) = happyShift action_21
action_215 (89) = happyShift action_80
action_215 (90) = happyShift action_22
action_215 (92) = happyShift action_24
action_215 (93) = happyShift action_181
action_215 (94) = happyShift action_182
action_215 (97) = happyShift action_2
action_215 (98) = happyShift action_81
action_215 (99) = happyShift action_82
action_215 (100) = happyShift action_83
action_215 (101) = happyShift action_25
action_215 (4) = happyGoto action_52
action_215 (5) = happyGoto action_53
action_215 (6) = happyGoto action_54
action_215 (7) = happyGoto action_55
action_215 (8) = happyGoto action_56
action_215 (14) = happyGoto action_170
action_215 (15) = happyGoto action_171
action_215 (17) = happyGoto action_10
action_215 (19) = happyGoto action_172
action_215 (21) = happyGoto action_216
action_215 (23) = happyGoto action_57
action_215 (24) = happyGoto action_58
action_215 (25) = happyGoto action_59
action_215 (26) = happyGoto action_60
action_215 (27) = happyGoto action_61
action_215 (28) = happyGoto action_62
action_215 (29) = happyGoto action_63
action_215 (30) = happyGoto action_64
action_215 (31) = happyGoto action_65
action_215 (32) = happyGoto action_66
action_215 (33) = happyGoto action_67
action_215 (34) = happyGoto action_68
action_215 (35) = happyGoto action_69
action_215 (37) = happyGoto action_70
action_215 (38) = happyGoto action_174
action_215 (39) = happyGoto action_72
action_215 (40) = happyGoto action_73
action_215 (41) = happyGoto action_74
action_215 (42) = happyGoto action_12
action_215 (43) = happyGoto action_175
action_215 (44) = happyGoto action_14
action_215 (46) = happyGoto action_176
action_215 _ = happyFail

action_216 _ = happyReduce_41

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn4
		 ((read ( happy_var_1)) :: Integer
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (PT _ (TD happy_var_1)))
	 =  HappyAbsSyn5
		 ((read ( happy_var_1)) :: Double
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (TC happy_var_1)))
	 =  HappyAbsSyn6
		 ((read ( happy_var_1)) :: Char
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyTerminal (PT _ (TL happy_var_1)))
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  8 happyReduction_5
happyReduction_5 (HappyTerminal (PT _ (T_Id happy_var_1)))
	 =  HappyAbsSyn8
		 (Id (happy_var_1)
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  9 happyReduction_6
happyReduction_6 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (AbsCpp.Prog (reverse happy_var_1)
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_0  10 happyReduction_7
happyReduction_7  =  HappyAbsSyn10
		 ([]
	)

happyReduce_8 = happySpecReduce_2  10 happyReduction_8
happyReduction_8 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  11 happyReduction_9
happyReduction_9 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 (AbsCpp.DFun happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_2  11 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn11
		 (AbsCpp.DTDef happy_var_1
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  11 happyReduction_11
happyReduction_11 _
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn11
		 (AbsCpp.DVar happy_var_1
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_2  11 happyReduction_12
happyReduction_12 _
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn11
		 (AbsCpp.DStruct happy_var_1
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  11 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn43  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (AbsCpp.DUsing happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_2  11 happyReduction_14
happyReduction_14 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (AbsCpp.DInline happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happyReduce 6 12 happyReduction_15
happyReduction_15 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	(HappyAbsSyn46  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (AbsCpp.FProto happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 8 12 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	(HappyAbsSyn46  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (AbsCpp.FDef happy_var_1 happy_var_2 happy_var_4 (reverse happy_var_7)
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_0  13 happyReduction_17
happyReduction_17  =  HappyAbsSyn13
		 ([]
	)

happyReduce_18 = happySpecReduce_1  13 happyReduction_18
happyReduction_18 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn13
		 ((:[]) happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  13 happyReduction_19
happyReduction_19 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn13
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  14 happyReduction_20
happyReduction_20 (HappyAbsSyn8  happy_var_3)
	(HappyAbsSyn46  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (AbsCpp.Typedef happy_var_2 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happyReduce 5 15 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsCpp.Struct happy_var_2 (reverse happy_var_4)
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_0  16 happyReduction_22
happyReduction_22  =  HappyAbsSyn16
		 ([]
	)

happyReduce_23 = happySpecReduce_3  16 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  17 happyReduction_24
happyReduction_24 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsCpp.DecSingle happy_var_1 happy_var_2
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  17 happyReduction_25
happyReduction_25 (HappyAbsSyn8  happy_var_3)
	(HappyAbsSyn46  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (AbsCpp.DecConst happy_var_2 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happyReduce 4 17 happyReduction_26
happyReduction_26 ((HappyAbsSyn23  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	(HappyAbsSyn46  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsCpp.DecInit happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 5 17 happyReduction_27
happyReduction_27 ((HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyAbsSyn46  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsCpp.DecInitConst happy_var_2 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_28 = happySpecReduce_1  18 happyReduction_28
happyReduction_28 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsCpp.ADec happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  18 happyReduction_29
happyReduction_29 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn18
		 (AbsCpp.ANoname happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  18 happyReduction_30
happyReduction_30 (HappyAbsSyn46  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (AbsCpp.ANonameConst happy_var_2
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  19 happyReduction_31
happyReduction_31 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn19
		 (AbsCpp.VDec happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happyReduce 4 19 happyReduction_32
happyReduction_32 ((HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	(HappyAbsSyn46  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (AbsCpp.VMult happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_1  20 happyReduction_33
happyReduction_33 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn20
		 ((:[]) happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  20 happyReduction_34
happyReduction_34 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn20
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_2  21 happyReduction_35
happyReduction_35 _
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsCpp.SExpr happy_var_1
	)
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_2  21 happyReduction_36
happyReduction_36 _
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsCpp.SVar happy_var_1
	)
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  21 happyReduction_37
happyReduction_37 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (AbsCpp.SRet happy_var_2
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  21 happyReduction_38
happyReduction_38 _
	(HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (AbsCpp.SBlock (reverse happy_var_2)
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happyReduce 5 21 happyReduction_39
happyReduction_39 ((HappyAbsSyn21  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (AbsCpp.SWhile happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_40 = happyReduce 7 21 happyReduction_40
happyReduction_40 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (AbsCpp.SDoWhile happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_41 = happyReduce 9 21 happyReduction_41
happyReduction_41 ((HappyAbsSyn21  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (AbsCpp.SFor happy_var_3 happy_var_5 happy_var_7 happy_var_9
	) `HappyStk` happyRest

happyReduce_42 = happySpecReduce_2  21 happyReduction_42
happyReduction_42 _
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsCpp.STDef happy_var_1
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  21 happyReduction_43
happyReduction_43 _
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsCpp.SStruct happy_var_1
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 5 21 happyReduction_44
happyReduction_44 ((HappyAbsSyn21  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (AbsCpp.SIf happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_45 = happyReduce 7 21 happyReduction_45
happyReduction_45 ((HappyAbsSyn21  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (AbsCpp.SIfElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_46 = happySpecReduce_0  22 happyReduction_46
happyReduction_46  =  HappyAbsSyn22
		 ([]
	)

happyReduce_47 = happySpecReduce_2  22 happyReduction_47
happyReduction_47 (HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  23 happyReduction_48
happyReduction_48 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EInt happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  23 happyReduction_49
happyReduction_49 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EDbl happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  23 happyReduction_50
happyReduction_50 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EChar happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  23 happyReduction_51
happyReduction_51 (HappyAbsSyn37  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EStrLit happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  23 happyReduction_52
happyReduction_52 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (happy_var_2
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  24 happyReduction_53
happyReduction_53 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EConst happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happyReduce 4 24 happyReduction_54
happyReduction_54 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (AbsCpp.EIndex happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_55 = happyReduce 4 24 happyReduction_55
happyReduction_55 (_ `HappyStk`
	(HappyAbsSyn36  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (AbsCpp.EFunCall happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_56 = happySpecReduce_1  24 happyReduction_56
happyReduction_56 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  25 happyReduction_57
happyReduction_57 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EStrDot happy_var_1 happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  25 happyReduction_58
happyReduction_58 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EStrArr happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_2  25 happyReduction_59
happyReduction_59 _
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EPostInc happy_var_1
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  25 happyReduction_60
happyReduction_60 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (AbsCpp.EDeref happy_var_2
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  25 happyReduction_61
happyReduction_61 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_2  26 happyReduction_62
happyReduction_62 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (AbsCpp.EPreInc happy_var_2
	)
happyReduction_62 _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_2  26 happyReduction_63
happyReduction_63 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (AbsCpp.ENegate happy_var_2
	)
happyReduction_63 _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  26 happyReduction_64
happyReduction_64 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  27 happyReduction_65
happyReduction_65 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EMul happy_var_1 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  27 happyReduction_66
happyReduction_66 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EDiv happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  27 happyReduction_67
happyReduction_67 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EMod happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  27 happyReduction_68
happyReduction_68 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  28 happyReduction_69
happyReduction_69 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EAdd happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  28 happyReduction_70
happyReduction_70 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.ESub happy_var_1 happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  28 happyReduction_71
happyReduction_71 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  29 happyReduction_72
happyReduction_72 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.ELShift happy_var_1 happy_var_3
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  29 happyReduction_73
happyReduction_73 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.ERShift happy_var_1 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  29 happyReduction_74
happyReduction_74 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  30 happyReduction_75
happyReduction_75 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.ELt happy_var_1 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  30 happyReduction_76
happyReduction_76 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EGt happy_var_1 happy_var_3
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  30 happyReduction_77
happyReduction_77 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.ELtEq happy_var_1 happy_var_3
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  30 happyReduction_78
happyReduction_78 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EGtEq happy_var_1 happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  30 happyReduction_79
happyReduction_79 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_3  31 happyReduction_80
happyReduction_80 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EEqual happy_var_1 happy_var_3
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_3  31 happyReduction_81
happyReduction_81 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EIneq happy_var_1 happy_var_3
	)
happyReduction_81 _ _ _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_1  31 happyReduction_82
happyReduction_82 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_82 _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_3  32 happyReduction_83
happyReduction_83 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EAnd happy_var_1 happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  32 happyReduction_84
happyReduction_84 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_3  33 happyReduction_85
happyReduction_85 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EOr happy_var_1 happy_var_3
	)
happyReduction_85 _ _ _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  33 happyReduction_86
happyReduction_86 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_3  34 happyReduction_87
happyReduction_87 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EAssign happy_var_1 happy_var_3
	)
happyReduction_87 _ _ _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_3  34 happyReduction_88
happyReduction_88 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EAssignInc happy_var_1 happy_var_3
	)
happyReduction_88 _ _ _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  34 happyReduction_89
happyReduction_89 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (AbsCpp.EAssignDec happy_var_1 happy_var_3
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happyReduce 5 34 happyReduction_90
happyReduction_90 ((HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (AbsCpp.ETernary happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_91 = happySpecReduce_1  34 happyReduction_91
happyReduction_91 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_91 _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_2  35 happyReduction_92
happyReduction_92 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (AbsCpp.EThrtow happy_var_2
	)
happyReduction_92 _ _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_1  35 happyReduction_93
happyReduction_93 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_0  36 happyReduction_94
happyReduction_94  =  HappyAbsSyn36
		 ([]
	)

happyReduce_95 = happySpecReduce_1  36 happyReduction_95
happyReduction_95 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn36
		 ((:[]) happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_3  36 happyReduction_96
happyReduction_96 (HappyAbsSyn36  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn36
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_96 _ _ _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  37 happyReduction_97
happyReduction_97 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn37
		 ((:[]) happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_2  37 happyReduction_98
happyReduction_98 (HappyAbsSyn37  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn37
		 ((:) happy_var_1 happy_var_2
	)
happyReduction_98 _ _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  38 happyReduction_99
happyReduction_99 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  39 happyReduction_100
happyReduction_100 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  40 happyReduction_101
happyReduction_101 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  41 happyReduction_102
happyReduction_102 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happyReduce 4 42 happyReduction_103
happyReduction_103 (_ `HappyStk`
	(HappyAbsSyn45  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn42
		 (AbsCpp.CTempl happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_104 = happySpecReduce_1  42 happyReduction_104
happyReduction_104 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn42
		 (AbsCpp.CId happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_1  43 happyReduction_105
happyReduction_105 (HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn43
		 (AbsCpp.QCon happy_var_1
	)
happyReduction_105 _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  44 happyReduction_106
happyReduction_106 (HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn44
		 ((:[]) happy_var_1
	)
happyReduction_106 _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_3  44 happyReduction_107
happyReduction_107 (HappyAbsSyn44  happy_var_3)
	_
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn44
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_107 _ _ _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_1  45 happyReduction_108
happyReduction_108 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn45
		 ((:[]) happy_var_1
	)
happyReduction_108 _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_3  45 happyReduction_109
happyReduction_109 (HappyAbsSyn45  happy_var_3)
	_
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn45
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_109 _ _ _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_1  46 happyReduction_110
happyReduction_110 _
	 =  HappyAbsSyn46
		 (AbsCpp.TVoid
	)

happyReduce_111 = happySpecReduce_1  46 happyReduction_111
happyReduction_111 _
	 =  HappyAbsSyn46
		 (AbsCpp.TBool
	)

happyReduce_112 = happySpecReduce_1  46 happyReduction_112
happyReduction_112 _
	 =  HappyAbsSyn46
		 (AbsCpp.TInt
	)

happyReduce_113 = happySpecReduce_1  46 happyReduction_113
happyReduction_113 _
	 =  HappyAbsSyn46
		 (AbsCpp.TDoube
	)

happyReduce_114 = happySpecReduce_1  46 happyReduction_114
happyReduction_114 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn46
		 (AbsCpp.TConst happy_var_1
	)
happyReduction_114 _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_2  46 happyReduction_115
happyReduction_115 _
	(HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn46
		 (AbsCpp.TRef happy_var_1
	)
happyReduction_115 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 102 102 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 47;
	PT _ (TS _ 2) -> cont 48;
	PT _ (TS _ 3) -> cont 49;
	PT _ (TS _ 4) -> cont 50;
	PT _ (TS _ 5) -> cont 51;
	PT _ (TS _ 6) -> cont 52;
	PT _ (TS _ 7) -> cont 53;
	PT _ (TS _ 8) -> cont 54;
	PT _ (TS _ 9) -> cont 55;
	PT _ (TS _ 10) -> cont 56;
	PT _ (TS _ 11) -> cont 57;
	PT _ (TS _ 12) -> cont 58;
	PT _ (TS _ 13) -> cont 59;
	PT _ (TS _ 14) -> cont 60;
	PT _ (TS _ 15) -> cont 61;
	PT _ (TS _ 16) -> cont 62;
	PT _ (TS _ 17) -> cont 63;
	PT _ (TS _ 18) -> cont 64;
	PT _ (TS _ 19) -> cont 65;
	PT _ (TS _ 20) -> cont 66;
	PT _ (TS _ 21) -> cont 67;
	PT _ (TS _ 22) -> cont 68;
	PT _ (TS _ 23) -> cont 69;
	PT _ (TS _ 24) -> cont 70;
	PT _ (TS _ 25) -> cont 71;
	PT _ (TS _ 26) -> cont 72;
	PT _ (TS _ 27) -> cont 73;
	PT _ (TS _ 28) -> cont 74;
	PT _ (TS _ 29) -> cont 75;
	PT _ (TS _ 30) -> cont 76;
	PT _ (TS _ 31) -> cont 77;
	PT _ (TS _ 32) -> cont 78;
	PT _ (TS _ 33) -> cont 79;
	PT _ (TS _ 34) -> cont 80;
	PT _ (TS _ 35) -> cont 81;
	PT _ (TS _ 36) -> cont 82;
	PT _ (TS _ 37) -> cont 83;
	PT _ (TS _ 38) -> cont 84;
	PT _ (TS _ 39) -> cont 85;
	PT _ (TS _ 40) -> cont 86;
	PT _ (TS _ 41) -> cont 87;
	PT _ (TS _ 42) -> cont 88;
	PT _ (TS _ 43) -> cont 89;
	PT _ (TS _ 44) -> cont 90;
	PT _ (TS _ 45) -> cont 91;
	PT _ (TS _ 46) -> cont 92;
	PT _ (TS _ 47) -> cont 93;
	PT _ (TS _ 48) -> cont 94;
	PT _ (TS _ 49) -> cont 95;
	PT _ (TS _ 50) -> cont 96;
	PT _ (TI happy_dollar_dollar) -> cont 97;
	PT _ (TD happy_dollar_dollar) -> cont 98;
	PT _ (TC happy_dollar_dollar) -> cont 99;
	PT _ (TL happy_dollar_dollar) -> cont 100;
	PT _ (T_Id happy_dollar_dollar) -> cont 101;
	_ -> happyError' (tk:tks)
	}

happyError_ 102 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => [(Token)] -> Err a
happyError' = happyError

pProgram tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn9 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
{-# LINE 1 "templates\GenericTemplate.hs" #-}
{-# LINE 1 "templates\\GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "G:\\GitHub\\haskell-platform\\build\\ghc-bindist\\local\\lib/include\\ghcversion.h" #-}

















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates\\GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates\\GenericTemplate.hs" #-}

{-# LINE 46 "templates\\GenericTemplate.hs" #-}








{-# LINE 67 "templates\\GenericTemplate.hs" #-}

{-# LINE 77 "templates\\GenericTemplate.hs" #-}

{-# LINE 86 "templates\\GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates\\GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 256 "templates\\GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 322 "templates\\GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
