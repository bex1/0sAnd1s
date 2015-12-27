.class public core017
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core017/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 4
istore 0
bipush 1
ldc 3
iload 0
if_icmple l6
pop
bipush 0
l6:
ifeq l4
bipush 1
ldc 4
ldc 2
if_icmpne l9
pop
bipush 0
l9:
ifeq l7
iconst_1
goto l8
l7:
iconst_0
l8:
goto l5
l4:
iconst_0
l5:
ifeq l2
iconst_1
ifeq l10
iconst_1
goto l11
l10:
iconst_0
l11:
goto l3
l2:
iconst_0
l3:
ifeq l0
iconst_1
invokestatic core017/printBool(Z)V
goto l1
l0:
l1:
iconst_1
iconst_1
invokestatic core017/eq_bool(ZZ)Z
ifeq l12
iconst_1
goto l13
l12:
ldc 1
invokestatic core017/dontCallMe(I)Z
ifeq l14
iconst_1
goto l15
l14:
iconst_0
l15:
l13:
invokestatic core017/printBool(Z)V
bipush 1
ldc2_w 4.0
ldc2_w 50.0
dcmpl
ifgt l18
pop
bipush 0
l18:
ifeq l16
ldc 2
invokestatic core017/dontCallMe(I)Z
ifeq l19
iconst_1
goto l20
l19:
iconst_0
l20:
goto l17
l16:
iconst_0
l17:
invokestatic core017/printBool(Z)V
bipush 1
ldc 4
iload 0
if_icmpeq l25
pop
bipush 0
l25:
ifeq l23
iconst_1
iconst_0
invokestatic core017/eq_bool(ZZ)Z
ifeq l26
iconst_1
goto l27
l26:
iconst_0
l27:
goto l24
l23:
iconst_0
l24:
ifeq l21
iconst_1
ifeq l28
iconst_1
goto l29
l28:
iconst_0
l29:
goto l22
l21:
iconst_0
l22:
invokestatic core017/printBool(Z)V
iconst_0
iconst_0
invokestatic core017/implies(ZZ)Z
invokestatic core017/printBool(Z)V
iconst_0
iconst_1
invokestatic core017/implies(ZZ)Z
invokestatic core017/printBool(Z)V
iconst_1
iconst_0
invokestatic core017/implies(ZZ)Z
invokestatic core017/printBool(Z)V
iconst_1
iconst_1
invokestatic core017/implies(ZZ)Z
invokestatic core017/printBool(Z)V
ldc 0
ireturn
iconst_0
ireturn
.end method
.method public static dontCallMe(I)Z
.limit locals 100
.limit stack 1000
iload 0
iload 0
invokestatic Runtime/printInt(I)V
iconst_1
ireturn
iconst_0
ireturn
.end method
.method public static printBool(Z)V
.limit locals 100
.limit stack 1000
iload 0
iload 0
ifeq l30
ldc 1
invokestatic Runtime/printInt(I)V
goto l31
l30:
ldc 0
invokestatic Runtime/printInt(I)V
l31:
return
.end method
.method public static implies(ZZ)Z
.limit locals 100
.limit stack 1000
iload 0
iload 1
iload 0
invokestatic core017/not(Z)Z
ifeq l32
iconst_1
goto l33
l32:
iload 0
iload 1
invokestatic core017/eq_bool(ZZ)Z
ifeq l34
iconst_1
goto l35
l34:
iconst_0
l35:
l33:
ireturn
iconst_0
ireturn
.end method
.method public static not(Z)Z
.limit locals 100
.limit stack 1000
iload 0
iconst_0
istore 1
iload 0
ifeq l36
iconst_0
dup
istore 1
pop
goto l37
l36:
iconst_1
dup
istore 1
pop
l37:
iload 1
ireturn
iconst_0
ireturn
.end method
.method public static eq_bool(ZZ)Z
.limit locals 100
.limit stack 1000
iload 0
iload 1
iconst_0
istore 2
iload 0
ifeq l38
iload 1
dup
istore 2
pop
goto l39
l38:
iload 1
invokestatic core017/not(Z)Z
dup
istore 2
pop
l39:
iload 2
ireturn
iconst_0
ireturn
.end method
