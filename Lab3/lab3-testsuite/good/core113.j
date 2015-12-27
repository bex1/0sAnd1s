.class public core113
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core113/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 45
invokestatic core113/f(I)I
invokestatic Runtime/printInt(I)V
ldc 450
invokestatic core113/f(I)I
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
iconst_0
ireturn
.end method
.method public static f(I)I
.limit locals 100
.limit stack 1000
iload 0
iconst_0
istore 1
bipush 1
iload 0
ldc 100
if_icmplt l2
pop
bipush 0
l2:
ifeq l0
ldc 91
istore 2
iload 2
dup
istore 1
pop
goto l1
l0:
iload 0
dup
istore 1
pop
l1:
iload 1
ireturn
iconst_0
ireturn
.end method
