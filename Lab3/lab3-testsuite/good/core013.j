.class public core013
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core013/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 0
ldc 1
isub
invokestatic core013/test(I)Z
ifeq l0
ldc 0
invokestatic core013/test(I)Z
ifeq l2
iconst_1
goto l3
l2:
iconst_0
l3:
goto l1
l0:
iconst_0
l1:
invokestatic core013/printBool(Z)V
ldc 0
ldc 2
isub
invokestatic core013/test(I)Z
ifeq l4
iconst_1
goto l5
l4:
ldc 1
invokestatic core013/test(I)Z
ifeq l6
iconst_1
goto l7
l6:
iconst_0
l7:
l5:
invokestatic core013/printBool(Z)V
ldc 3
invokestatic core013/test(I)Z
ifeq l10
ldc 0
ldc 5
isub
invokestatic core013/test(I)Z
ifeq l12
iconst_1
goto l13
l12:
iconst_0
l13:
goto l11
l10:
iconst_0
l11:
ifeq l8
iconst_1
ifeq l14
iconst_1
goto l15
l14:
iconst_0
l15:
goto l9
l8:
iconst_0
l9:
invokestatic core013/printBool(Z)V
ldc 3
invokestatic core013/test(I)Z
ifeq l16
iconst_1
goto l17
l16:
ldc 0
ldc 5
isub
invokestatic core013/test(I)Z
ifeq l20
iconst_1
ifeq l22
iconst_1
goto l23
l22:
iconst_0
l23:
goto l21
l20:
iconst_0
l21:
ifeq l18
iconst_1
goto l19
l18:
iconst_0
l19:
l17:
invokestatic core013/printBool(Z)V
iconst_1
invokestatic core013/printBool(Z)V
iconst_0
invokestatic core013/printBool(Z)V
ldc 0
ireturn
iconst_0
ireturn
.end method
.method public static printBool(Z)V
.limit locals 100
.limit stack 1000
iload 0
iload 0
ifeq l24
goto l25
l24:
l25:
return
.end method
.method public static test(I)Z
.limit locals 100
.limit stack 1000
iload 0
bipush 1
iload 0
ldc 0
if_icmpgt l26
pop
bipush 0
l26:
ireturn
iconst_0
ireturn
.end method
