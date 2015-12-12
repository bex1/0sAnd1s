.class public good07
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic good07/main()I
pop
return

.end method

.method public static main()I
.limit locals 100
.limit stack 1000
invokestatic Runtime/readInt()I
istore 0
iload 0
ldc 2
idiv
istore 1
l0:
bipush 1
iload 1
ldc 1
if_icmpgt l2
pop
bipush 0
l2:
ifeq l1
bipush 1
iload 1
iload 0
iload 1
idiv
imul
iload 0
if_icmpeq l5
pop
bipush 0
l5:
ifeq l3
iload 1
invokestatic Runtime/printInt(I)V
goto l4
l3:
l4:
iload 1
dup
iconst_1
isub
istore 1
pop
goto l0
l1:
iconst_0
ireturn
.end method
