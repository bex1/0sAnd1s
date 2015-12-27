.class public core006
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core006/main()I
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
ldc 45
dup
istore 0
pop
ldc 36
ldc 67
iadd
dup
istore 1
pop
iload 0
invokestatic Runtime/printInt(I)V
iload 1
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
iconst_0
ireturn
.end method
