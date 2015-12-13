.class public core010
.super java/lang/Object
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method
.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000
invokestatic core010/main()I
pop
return
.end method
.method public static main()I
.limit locals 100
.limit stack 1000
ldc 5
invokestatic core010/fac(I)I
invokestatic Runtime/printInt(I)V
ldc 0
ireturn
iconst_0
ireturn
.end method
.method public static fac(I)I
.limit locals 100
.limit stack 1000
iload 0
iconst_0
istore 1
iconst_0
istore 2
ldc 1
dup
istore 1
pop
iload 0
dup
istore 2
pop
l0:
bipush 1
iload 2
ldc 0
if_icmpgt l2
pop
bipush 0
l2:
ifeq l1
iload 1
iload 2
imul
dup
istore 1
pop
iload 2
ldc 1
isub
dup
istore 2
pop
goto l0
l1:
iload 1
ireturn
iconst_0
ireturn
.end method
