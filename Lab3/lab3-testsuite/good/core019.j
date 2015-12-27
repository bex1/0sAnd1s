.class public core019
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core019/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 78
istore 0
ldc 1
istore 1
iload 1
invokestatic Runtime/printInt(I)V
iload 0
invokestatic Runtime/printInt(I)V
l0:
bipush 1
iload 0
ldc 76
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
pop
iload 0
invokestatic Runtime/printInt(I)V
ldc 7
istore 2
iload 2
invokestatic Runtime/printInt(I)V
goto l0
l1:
iload 0
invokestatic Runtime/printInt(I)V
bipush 1
iload 0
ldc 4
if_icmpgt l5
pop
bipush 0
l5:
ifeq l3
ldc 4
istore 3
iload 3
invokestatic Runtime/printInt(I)V
goto l4
l3:
l4:
iload 0
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
iconst_0
ireturn
.end method
