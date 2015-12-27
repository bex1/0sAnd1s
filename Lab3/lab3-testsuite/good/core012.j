.class public core012
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core012/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 56
istore 0
ldc 23
istore 1
iload 0
iload 1
iadd
invokestatic Runtime/printInt(I)V
iload 0
iload 1
isub
invokestatic Runtime/printInt(I)V
iload 0
iload 1
imul
invokestatic Runtime/printInt(I)V
ldc 45
ldc 2
idiv
invokestatic Runtime/printInt(I)V
ldc2_w 9.3
dstore 2
ldc2_w 5.1
dstore 4
bipush 1
dload 2
dload 4
dadd
dload 2
dload 4
dsub
dcmpl
ifgt l0
pop
bipush 0
l0:
invokestatic core012/printBool(Z)V
bipush 1
dload 2
dload 4
ddiv
dload 2
dload 4
dmul
dcmpl
ifle l1
pop
bipush 0
l1:
invokestatic core012/printBool(Z)V
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
ifeq l2
goto l3
l2:
l3:
return
.end method
