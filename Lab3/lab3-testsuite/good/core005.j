.class public core005
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core005/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
iconst_0
istore 0
ldc 56
istore 1
bipush 1
iload 1
ldc 45
iadd
ldc 2
if_icmple l2
pop
bipush 0
l2:
ifeq l0
ldc 1
dup
istore 0
pop
goto l1
l0:
ldc 2
dup
istore 0
pop
l1:
iload 0
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
iconst_0
ireturn
.end method
