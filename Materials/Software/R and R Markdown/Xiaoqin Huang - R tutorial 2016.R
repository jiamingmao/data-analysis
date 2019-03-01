###############################
###############################
###############################
########### R Tutorial ########
###############################
###############################
###############################

#Open up R

#Setting your working directory tells R where to look for files

#########################
#Data Types##############
#########################

#Scalars & Vectors
##################

#Scalars
a =1
b ="B"
c =TRUE

class(a)
class(b)
class(c)

#Vectors
x=c(1,2,3,4,5)
xx=c(x,6,7,8,9,10)
xx =c(x,xx)
xx

#Colons create a vector between integers counting up by 1
y=1:10

#They can also count in reverse
y1=10:1

#These sequences can be generalized
y2=seq(1,10,length.out = 20)

#Vectors can also be created by repeating values
y3=rep(c(1,2), c(3,4))

rep(c(1,2), each = 3)
rep(c(1,2), 3)
g=c(1,2)


#Vectors can also contain other data types
z1=c("a", "b", "c", "d", "e")

# two equal sign is different from one equal sign
z2=y3==2

#Indexing Vectors
#################

x=sample(1:10, 10, replace=T)
y=sample(1:10, 10, replace=T)

#You can name elements of a vector
names(x)=letters[1:10]

#Using numbers to index vectors
x[1]
x[1:5]
x[10:6]
x[c(1,3,5)]

#Using names to index vectors
x[c('a', 'c', 'e')]

#Logical expressions
x[x>5]
x[x==1 | x==2]
x[x %in% c(1,2)]

#You can also index according to values from  a different vector.
x[y>5]

#You should be careful about NAs when indexing
x1=c(x, NA)
x1[x1>5]


#Use 'which' to avoid grabbing NAs accidentally
x1[which(x1>5)]

#This is not problem when using %in%
x1[x1 %in% c(1,2)]
#You can also grab the vector that isn't NA
x1[!is.na(x1)]

#You can also index an indexed vector
x[x>5][1:2]

#Vector functions
#################
#Here are some, among many
length(x)
range(x)
min(x)
max(x)
sort(x)
ls()
rm(x,y)

#Matrices
#########

mat1= matrix(1:9, nrow = 3, ncol = 3)
mat1
sqrt(mat1)
mat1^2
mat2= matrix(1:9, nrow = 3, ncol = 3, byrow=T)
mat2
c6=c(1,2,5,7,90,29,21,32,35)
mat6=matrix(c6,nrow=3,ncol=3)
#You can also build matrices from vectors
#By combining rows
mat3=rbind(1:5, 6:10, 11:15)
mat3

#and by combining columns
x1=rnorm(10000)
x2=rnorm(20)
mat4=cbind(x1,x2)
mat4

hist(x1)
#reproduce the exact same set of ramdon numbers
x=rnorm(50)
e=rnorm(50)
y=3*x+e

set.seed(300)
x=rnorm(50)
y=x+rnorm(50,50,0.1)
c=cor(x,y)
c

m=mean(x)
var=var(x)
sd=sqrt(var)


#The rows and columns of matrices can be named
mat5= cbind(mat4, mat4)
colnames(mat5) = paste("var",1:4, sep="")
row.names(mat5) =paste("row",1:20, sep="")

mat5

#Indexing matrices
#You again use brackets [], but now you can provide two numbers [i,j] for row i and column j.

mat5[1,1]
mat5[2,4]

#To extract an entire row or an entire column, you can leave the other entry blank
#Column 3
mat5[,3]

#Row 3
mat5[3,]

#You can also select multiple columns or rows at the same time
mat5[1:3,1:2]

#If you use matrices to model networks, you may want to create an adjacency matrix in which a '1' in row i, column j expresses a link between two nodes. You can use indexing to label a list of nodes


#There are many useful matrix commands 
#Some include
dim(mat5)
ncol(mat5)
nrow(mat5)
head(mat5)
tail(mat5)

#It is important to know that matrices can only include data of one class. 
#If you have one value that is a character, the entire matrix will change to character.
mat5[1,1]= "a"
mat5
class(mat5[1,2])


#graphics
x=rnorm(100)
y=rnorm(100)
plot(x,y)
plot(x,y,xlab=" this is the x-axis",ylab=" this is the y-axis",
     main=" Plot of X vs Y")


# a little complicated, if you understand the function ,pleaselet me know
x=seq(-pi ,pi ,length =50)
y=x
f=outer(x,y,function(x,y)cos(y)/(1+x^2))
contour(x,y,f)
contour (x,y,f,nlevels =45, add=T)
fa=(f-t(f))/2
contour (x,y,fa,nlevels =15)
image(x,y,fa)
persp(x,y,fa)
persp(x,y,fa ,theta =30)
persp(x,y,fa ,theta =30, phi =20)
persp(x,y,fa ,theta =30, phi =70)
persp(x,y,fa ,theta =30, phi =40)



#Reading in data to R
#####################
Auto=read.table("auto.txt",header=T,na.strings = "?")
fix(Auto)
Auto=read.csv("Auto.csv",header=T,na.strings = "?")
Auto2=na.omit(Auto)
dim(Auto2)
fix(Auto2)
names(Auto2)

# addtional graphics and summaries
plot(cylinders,mpg)
plot(Auto2$cylinders,Auto2$mpg)
# or 
attach(Auto2)
plot(cylinders,mpg)
# convert to qualitative variable
cylinders=as.factor(cylinders)
plot(cylinders,mpg)
plot(cylinders,mpg,col ="red", xlab=" cylinders ",  ylab ="MPG ")
hist(mpg ,col ="grey", breaks =15)
pairs(Auto)
pairs(~mpg+displacement+horsepower+weight+acceleration,Auto)
plot(horsepower,mpg)
identify(horsepower,mpg,name)

summary (Auto)
summary (mpg)

q()
