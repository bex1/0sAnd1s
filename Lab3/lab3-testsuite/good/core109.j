.class public core109
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic core109/main()I
pop
return

.end method

.method public static main()I
.limit locals 100
.limit stack 1000
ldc 4
istore 0
iload 0
invokestatic Runtime/printInt(I)V
iload 0
ireturn
iconst_0
ireturn
.end method
