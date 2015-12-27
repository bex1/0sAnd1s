.class public core001
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core001/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 10
invokestatic core001/fac(I)I
invokestatic Runtime/printInt(I)V
ldc 10
invokestatic core001/rfac(I)I
invokestatic Runtime/printInt(I)V
ldc 10
invokestatic core001/mfac(I)I
invokestatic Runtime/printInt(I)V
ldc 10
invokestatic core001/ifac(I)I
invokestatic Runtime/printInt(I)V
dconst_0
dstore 0
ldc 10
istore 2
ldc 1
istore 3
l0:
bipush 1
iload 2
ldc 0
if_icmpgt l2
pop
bipush 0
l2:
ifeq l1
iload 3
iload 2
imul
dup
istore 3
pop
iload 2
ldc 1
isub
dup
istore 2
pop
goto l0
l1:
iload 3
invokestatic Runtime/printInt(I)V
ldc2_w 10.0
invokestatic core001/dfac(D)D
invokestatic Runtime/printDouble(D)V
ldc 0
ireturn
iconst_0
ireturn
.end method
.method public static fac(I)I
.limit locals 100
.limit stack 1000
iload 0
iconst_0
istore 1
iconst_0
istore 2
ldc 1
dup
istore 1
pop
iload 0
dup
istore 2
pop
l3:
bipush 1
iload 2
ldc 0
if_icmpgt l5
pop
bipush 0
l5:
ifeq l4
iload 1
iload 2
imul
dup
istore 1
pop
iload 2
ldc 1
isub
dup
istore 2
pop
goto l3
l4:
iload 1
ireturn
iconst_0
ireturn
.end method
.method public static rfac(I)I
.limit locals 100
.limit stack 1000
iload 0
iconst_0
istore 1
bipush 1
iload 0
ldc 0
if_icmpeq l8
pop
bipush 0
l8:
ifeq l6
ldc 1
dup
istore 1
pop
goto l7
l6:
iload 0
iload 0
ldc 1
isub
invokestatic core001/rfac(I)I
imul
dup
istore 1
pop
l7:
iload 1
ireturn
iconst_0
ireturn
.end method
.method public static mfac(I)I
.limit locals 100
.limit stack 1000
iload 0
iconst_0
istore 1
bipush 1
iload 0
ldc 0
if_icmpeq l11
pop
bipush 0
l11:
ifeq l9
ldc 1
dup
istore 1
pop
goto l10
l9:
iload 0
iload 0
ldc 1
isub
invokestatic core001/nfac(I)I
imul
dup
istore 1
pop
l10:
iload 1
ireturn
iconst_0
ireturn
.end method
.method public static nfac(I)I
.limit locals 100
.limit stack 1000
iload 0
iconst_0
istore 1
bipush 1
iload 0
ldc 0
if_icmpne l14
pop
bipush 0
l14:
ifeq l12
iload 0
ldc 1
isub
invokestatic core001/mfac(I)I
iload 0
imul
dup
istore 1
pop
goto l13
l12:
ldc 1
dup
istore 1
pop
l13:
iload 1
ireturn
iconst_0
ireturn
.end method
.method public static dfac(D)D
.limit locals 100
.limit stack 1000
dload 0
dconst_0
dstore 2
bipush 1
dload 0
ldc2_w 0.0
dcmpl
ifeq l17
pop
bipush 0
l17:
ifeq l15
ldc2_w 1.0
dup2
dstore 2
pop2
goto l16
l15:
dload 0
dload 0
ldc2_w 1.0
dsub
invokestatic core001/dfac(D)D
dmul
dup2
dstore 2
pop2
l16:
dload 2
dreturn
dconst_0
dreturn
.end method
.method public static ifac(I)I
.limit locals 100
.limit stack 1000
iload 0
ldc 1
iload 0
invokestatic core001/ifac2f(II)I
ireturn
iconst_0
ireturn
.end method
.method public static ifac2f(II)I
.limit locals 100
.limit stack 1000
iload 0
iload 1
iconst_0
istore 2
bipush 1
iload 0
iload 1
if_icmpeq l20
pop
bipush 0
l20:
ifeq l18
iload 0
dup
istore 2
pop
goto l19
l18:
bipush 1
iload 0
iload 1
if_icmpgt l23
pop
bipush 0
l23:
ifeq l21
ldc 1
dup
istore 2
pop
goto l22
l21:
iconst_0
istore 3
iload 0
iload 1
iadd
ldc 2
idiv
dup
istore 3
pop
iload 0
iload 3
invokestatic core001/ifac2f(II)I
iload 3
ldc 1
iadd
iload 1
invokestatic core001/ifac2f(II)I
imul
dup
istore 2
pop
l22:
l19:
iload 2
ireturn
iconst_0
ireturn
.end method
