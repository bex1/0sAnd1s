.class public core111
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic core111/main()I
pop
return

.end method

.method public static main()I
.limit locals 100
.limit stack 1000
invokestatic Runtime/readInt()I
ldc 1
isub
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
iconst_0
ireturn
.end method
