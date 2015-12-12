.class public core016
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic core016/main()I
pop
return

.end method

.method public static main()I
.limit locals 100
.limit stack 1000
ldc 17
istore 0
l0:
bipush 1
iload 0
ldc 0
if_icmpgt l2
pop
bipush 0
l2:
ifeq l1
iload 0
ldc 2
isub
dup
istore 0
pop
goto l0
l1:
bipush 1
iload 0
ldc 0
if_icmplt l5
pop
bipush 0
l5:
ifeq l3
ldc 0
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
goto l4
l3:
ldc 1
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
l4:
iconst_0
ireturn
.end method
