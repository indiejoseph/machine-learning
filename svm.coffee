svm = require 'svm'

N = 10
data = new Array N
labels= new Array N
data[0] = [ -0.4326 , 1.1909 ]
data[1] = [ 3.0     , 4.0 ]
data[2] = [ 0.1253  , -0.0376 ]
data[3] = [ 0.2877  , 0.3273 ]
data[4] = [ -1.1465 , 0.1746 ]
data[5] = [ 1.8133  , 2.1139 ]
data[6] = [ 2.7258  , 3.0668 ]
data[7] = [ 1.4117  , 2.0593 ]
data[8] = [ 4.1832  , 1.9044 ]
data[9] = [ 1.8636  , 1.1677 ]
labels[0]= 1
labels[1]= 1
labels[2]= 1
labels[3]= 1
labels[4]= 1
labels[5]= -1
labels[6]= -1
labels[7]= -1
labels[8]= -1
labels[9]= -1


svm = new svm.SVM()

svm.train(data, labels, { C: 1 }) # C is a parameter to SVM

testdata = [[0,0], [0,1], [1,0], [1,1]]
testlabels = svm.predict([testdata])

#print weights and offset
wb = svm.getWeights()
for i in [0...wb.w.length]
    console.log("w_%d = %d", i, wb.w[i])
console.log("b = %d", wb.b)

#print predicted margins
marg = svm.margins(data)
for i in [0...N]
    console.log("%d, %d", labels[i], marg[i])
