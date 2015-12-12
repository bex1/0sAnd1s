.class public core015
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic core015/main()I
pop
return

.end method

.method public static main()I
.limit locals 100
.limit stack 1000
ldc 17
invokestatic core015/ev(I)I
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
iconst_0
ireturn
.end method
.method public static ev(I)I
.limit locals 100
.limit stack 1000
iload 0
iconst_0
istore 1
bipush 1
iload 0
ldc 0
if_icmpgt l2
pop
bipush 0
l2:
ifeq l0
iload 0
ldc 2
isub
invokestatic core015/ev(I)I
dup
istore 1
pop
goto l1
l0:
bipush 1
iload 0
ldc 0
if_icmplt l5
pop
bipush 0
l5:
ifeq l3
ldc 0
dup
istore 1
pop
goto l4
l3:
ldc 1
dup
istore 1
pop
l4:
l1:
iload 1
ireturn
iconst_0
ireturn
.end method
