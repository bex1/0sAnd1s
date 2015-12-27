.class public core101
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core101/main()I
pop
return
.end method
.method public static foo(I)Z
.limit locals 100
.limit stack 1000
iload 0
bipush 1
iload 0
ldc 0
if_icmpeq l2
pop
bipush 0
l2:
ifeq l0
iconst_0
ireturn
goto l1
l0:
l1:
iconst_1
istore 1
iload 0
invokestatic Runtime/printInt(I)V
iload 1
ireturn
iconst_0
ireturn
.end method
.method public static printBool(Z)V
.limit locals 100
.limit stack 1000
iload 0
iconst_0
ifeq l3
goto l4
l3:
iload 0
ifeq l5
ldc 0
invokestatic Runtime/printInt(I)V
goto l6
l5:
ldc 1
invokestatic Runtime/printInt(I)V
l6:
l4:
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 42
invokestatic core101/foo(I)Z
invokestatic core101/printBool(Z)V
ldc 0
invokestatic core101/foo(I)Z
invokestatic core101/printBool(Z)V
ldc 0
ireturn
iconst_0
ireturn
.end method
