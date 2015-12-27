.class public good17
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic good17/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
iconst_0
istore 0
ldc 6
dup
istore 0
pop
iconst_0
istore 1
iload 0
ldc 7
iadd
dup
istore 1
pop
iload 1
invokestatic Runtime/printInt(I)V
iconst_0
istore 2
ldc 4
dup
istore 2
pop
iload 2
invokestatic Runtime/printInt(I)V
iload 2
dup
istore 0
pop
iload 0
invokestatic Runtime/printInt(I)V
iload 0
invokestatic Runtime/printInt(I)V
iload 1
invokestatic Runtime/printInt(I)V
iconst_0
ireturn
.end method
