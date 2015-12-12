.class public core103
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic core103/main()I
pop
return

.end method

.method public static main()I
.limit locals 100
.limit stack 1000
ldc 4
istore 0
l0:
bipush 1
iload 0
ldc 6
if_icmplt l2
pop
bipush 0
l2:
ifeq l1
ldc 0
istore 1
iload 1
dup
iconst_1
iadd
istore 1
pop
iload 1
invokestatic Runtime/printInt(I)V
iload 0
dup
iconst_1
iadd
istore 0
pop
goto l0
l1:
bipush 1
iload 0
ldc 7
if_icmplt l5
pop
bipush 0
l5:
ifeq l3
iload 0
dup
iconst_1
iadd
istore 0
pop
goto l4
l3:
iload 0
dup
iconst_1
isub
istore 0
pop
l4:
iload 0
invokestatic Runtime/printInt(I)V
iload 0
ireturn
iconst_0
ireturn
.end method
