.class public core102
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core102/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
l0:
bipush 1
ldc 2
ldc 5
ldc 6
imul
ldc 5
idiv
iadd
ldc 67
isub
ldc 5
if_icmpgt l2
pop
bipush 0
l2:
ifeq l1
goto l0
l1:
ldc 0
ireturn
iconst_0
ireturn
.end method
