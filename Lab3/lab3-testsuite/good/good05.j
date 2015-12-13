.class public good05
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic good05/main()I
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
iconst_0
istore 2
ldc 1
dup
istore 0
pop
iload 0
dup
istore 1
pop
invokestatic Runtime/readInt()I
dup
istore 2
pop
iload 0
invokestatic Runtime/printInt(I)V
l0:
bipush 1
iload 1
iload 2
if_icmplt l2
pop
bipush 0
l2:
ifeq l1
iload 1
invokestatic Runtime/printInt(I)V
iload 0
iload 1
iadd
dup
istore 1
pop
iload 1
iload 0
isub
dup
istore 0
pop
goto l0
l1:
iconst_0
ireturn
.end method
