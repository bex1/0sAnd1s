.class public core112
.super java/lang/Object

.method public <init>()V

aload_0
invokespecial java/lang/Object/<init>()V
return

.end method

.method public static main([Ljava/lang/String;)V
.limit locals 100
.limit stack 1000

invokestatic core112/main()I
pop
return

.end method

.method public static main()I
.limit locals 100
.limit stack 1000
ldc2_w 2.0
dstore 0
dload 0
invokestatic Runtime/printDouble(D)V
dload 0
dup2
dconst_1
dadd
dstore 0
pop2
dload 0
invokestatic Runtime/printDouble(D)V
dload 0
dup2
dconst_1
dsub
dstore 0
pop2
dload 0
invokestatic Runtime/printDouble(D)V
ldc 0
ireturn
iconst_0
ireturn
.end method
