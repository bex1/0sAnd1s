.class public good15
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic good15/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 1
istore 0
iload 0
invokestatic Runtime/printInt(I)V
iconst_1
ifeq l0
iconst_1
goto l1
l0:
bipush 1
iload 0
dup
iconst_1
iadd
istore 0
ldc 45
if_icmpne l4
pop
bipush 0
l4:
ifeq l2
iconst_1
goto l3
l2:
iconst_0
l3:
l1:
pop
iload 0
invokestatic Runtime/printInt(I)V
iconst_0
ifeq l5
iconst_1
goto l6
l5:
bipush 1
iload 0
dup
iconst_1
iadd
istore 0
ldc 0
if_icmpge l9
pop
bipush 0
l9:
ifeq l7
iconst_1
goto l8
l7:
iconst_0
l8:
l6:
pop
iload 0
invokestatic Runtime/printInt(I)V
iconst_1
ifeq l10
bipush 1
iload 0
dup
iconst_1
iadd
istore 0
ldc 0
if_icmplt l14
pop
bipush 0
l14:
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
pop
iload 0
invokestatic Runtime/printInt(I)V
iconst_0
ifeq l15
bipush 1
iload 0
dup
iconst_1
iadd
istore 0
ldc 0
if_icmpgt l19
pop
bipush 0
l19:
ifeq l17
iconst_1
goto l18
l17:
iconst_0
l18:
goto l16
l15:
iconst_0
l16:
pop
iload 0
invokestatic Runtime/printInt(I)V
ldc 0
istore 1
bipush 1
ldc 34
ldc 6
if_icmplt l24
pop
bipush 0
l24:
ifeq l22
bipush 1
iload 1
ldc 0
if_icmplt l27
pop
bipush 0
l27:
ifeq l25
iconst_1
goto l26
l25:
iconst_0
l26:
goto l23
l22:
iconst_0
l23:
ifeq l20
iload 0
invokestatic Runtime/printInt(I)V
goto l21
l20:
ldc 42
invokestatic Runtime/printInt(I)V
l21:
iconst_0
ireturn
.end method
