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
ldc 6
dup
istore 1
pop
iconst_0
istore 2
iload 1
ldc 7
iadd
dup
istore 2
pop
iload 2
invokestatic Runtime/printInt(I)V
iconst_0
istore 3
ldc 4
dup
istore 3
pop
iload 3
invokestatic Runtime/printInt(I)V
iload 3
dup
istore 1
pop
iload 1
invokestatic Runtime/printInt(I)V
iload 1
invokestatic Runtime/printInt(I)V
iload 2
invokestatic Runtime/printInt(I)V
iconst_0
ireturn
.end method
