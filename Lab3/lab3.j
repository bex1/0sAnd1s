.class public test
.super java/lang/Object

.method public <init>()V
aload_0
invokenonvirtual java/lang/Object/<init>()V
return
.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic test/main2()I
return
.end method
.method public static main2()I
.limit locals 100
.limit stack 1000
iconst_0
istore 1
iconst_0
istore 2
iconst_0
istore 3
ldc 1
dup
istore 1
pop
iload 1
dup
istore 2
pop
invokestatic Runtime/readInt()I
dup
istore 3
pop
iload 1
invokestatic Runtime/printInt(I)V
l0:
bipush 1
iload 2
iload 3
if_icmplt l2
pop
bipush 0
l2:
ifeq l1
iload 2
invokestatic Runtime/printInt(I)V
iload 1
iload 2
iadd
dup
istore 2
pop
iload 2
iload 1
isub
dup
istore 1
pop
goto l0
l1:
iconst_0
ireturn
.end method
