.class public core106
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core106/main()I
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
ldc 6
dup
istore 2
dup
istore 1
pop
iload 2
iload 1
iadd
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
iconst_0
ireturn
.end method
