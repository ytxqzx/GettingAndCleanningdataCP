
featurenames <- read.table("features.txt")
Alable <- read.table("activity_labels.txt")

pl1 <- c("test", "train")

fn1 <- list.files(file.path(getwd(),pl1[1]))
fn2 <- list.files(file.path(getwd(),pl1[2]))

id <- rbind(read.table(file.path(getwd(),pl1[1],fn1[2]), sep ="", col.names = "id"),
            read.table(file.path(getwd(),pl1[2], fn2[2]), sep ="", col.names = "id"))

lable <- rbind(read.table(file.path(getwd(),pl1[1],fn1[4]), sep ="", col.names = "lable"),
               read.table(file.path(getwd(),pl1[2], fn2[4]), sep ="", col.names = "lable"))

TimeFre <- rbind(read.table(file.path(getwd(),pl1[1],fn1[3]), sep =""),
                 read.table(file.path(getwd(),pl1[2], fn2[3]), sep =""))
colnames(TimeFre) <- featurenames[,2]


data <- cbind (id,lable,TimeFre)
data1 <- data
data1[,2] <- factor(data1[,2])
levels(data1[,2])<-Alable[,2]
write.table(data1, file = "merged_data.txt",row.name=FALSE)




x <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,
       266:271,345:350,424:429,503:504,516:517,529:530,542,543)
x <-c(1:2,x+2)
subdata <- data[,x]


cdata <- data.frame(matrix(vector(), 180, length(subdata[1,]), dimnames=list(c(), colnames(subdata))))
cdata[,1] <- rep(1:30,each =6)
cdata[,2] <- rep(1:6, time = 30)
m <- 1

for (i in 1:30){
      for (j in 1:6){
            dt <- subset(subdata, subdata$id== i&subdata$lable == j)
            cdata[m,] <- colMeans(dt)
            m <- m+1
      }
}
write.table(cdata, file = "tidedata.txt",row.name=FALSE)


