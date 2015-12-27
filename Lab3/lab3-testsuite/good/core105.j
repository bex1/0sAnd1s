.class public core105
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core105/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 5
istore 0
l0:
bipush 1
iload 0
ldc 3
if_icmpgt l2
pop
bipush 0
l2:
ifeq l1
iload 0
dup
iconst_1
isub
istore 0
invokestatic Runtime/printInt(I)V
goto l0
l1:
iload 0
ireturn
iconst_0
ireturn
.end method
