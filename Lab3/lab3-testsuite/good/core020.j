.class public core020
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic core020/main()I
pop
return

.end method
.method public static bar()V
.limit locals 100
.limit stack 1000
invokestatic core020/foo()V
return
return
.end method

.method public static main()I
.limit locals 100
.limit stack 1000
invokestatic core020/bar()V
invokestatic core020/foo()V
ldc 0
ireturn
iconst_0
ireturn
.end method
.method public static foo()V
.limit locals 100
.limit stack 1000
return
.end method
