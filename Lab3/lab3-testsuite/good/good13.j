.class public good13
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic good13/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
iconst_0
istore 0
iconst_0
istore 1
invokestatic Runtime/readInt()I
dup
istore 0
pop
ldc 2
dup
istore 1
pop
l0:
bipush 1
iload 1
iload 0
if_icmple l2
pop
bipush 0
l2:
ifeq l1
iconst_1
istore 2
ldc 2
istore 3
l3:
bipush 1
iload 3
iload 3
imul
iload 1
if_icmple l7
pop
bipush 0
l7:
ifeq l5
iload 2
ifeq l8
iconst_1
goto l9
l8:
iconst_0
l9:
goto l6
l5:
iconst_0
l6:
ifeq l4
bipush 1
iload 1
iload 3
idiv
iload 3
imul
iload 1
if_icmpeq l12
pop
bipush 0
l12:
ifeq l10
iconst_0
dup
istore 2
pop
goto l11
l10:
l11:
iload 3
dup
iconst_1
iadd
istore 3
pop
goto l3
l4:
iload 2
ifeq l15
bipush 1
iload 0
iload 1
idiv
iload 1
imul
iload 0
if_icmpeq l19
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
ifeq l13
iload 1
invokestatic Runtime/printInt(I)V
iload 0
iload 1
idiv
dup
istore 0
pop
goto l14
l13:
iload 1
dup
iconst_1
iadd
istore 1
pop
l14:
goto l0
l1:
ldc 0
ireturn
iconst_0
ireturn
.end method
