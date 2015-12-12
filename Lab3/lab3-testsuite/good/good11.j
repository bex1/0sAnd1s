.class public good11
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic good11/main()I
pop
return

.end method

.method public static main()I
.limit locals 100
.limit stack 1000
ldc 0
istore 0
ldc 0
istore 1
iconst_0
istore 2
l0:
bipush 1
invokestatic Runtime/readInt()I
dup
istore 2
ldc 0
if_icmpne l2
pop
bipush 0
l2:
ifeq l1
iload 0
iload 2
iadd
dup
istore 0
pop
iload 1
dup
iconst_1
iadd
istore 1
pop
goto l0
l1:
iload 0
iload 1
idiv
invokestatic Runtime/printInt(I)V
iconst_0
ireturn
.end method
