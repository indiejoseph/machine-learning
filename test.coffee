###
Hidden Markov Model
###
console.log '''
-------------------
Hidden Markov Model
-------------------
'''

HMM = require './hmm'
states = [
    'Rainy',
    'Sunny'
]
observations = [
    'walk',
    'shop',
    'clean'
]

hmm = new HMM states.length, observations.length
train = [
    [[0, 1, 2]],
    [[1, 0, 0]]
]
hmm.learn train[0], train[1]
# hmm.t = [
# [0.7, 0.3],
# [0.4, 0.6]
# ]
# hmm.e = [
# [0.1, 0.4, 0.5],
# [0.6, 0.3, 0.1]
# ]
# hmm.pi = [0.6, 0.4]

results = hmm.viterbi [0, 1, 2]

console.log results
for i in [0...results[1].length]
    state = results[1][i]
    console.log states[state]


###
Support Vector Model
###
console.log '''
--------------------
Support Vector Model
--------------------
'''

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


###
K-means
###

console.log '''
-------------------
K-means
-------------------
'''

KMeans = require './kmeans'

# Data source: LinkedIn
# Initial data are businesses that need to be clustered according to their size (nb of employees) and revenue (in mln$)

data = [
  { 'company': 'Microsoft', 'size': 91259,  'revenue': 60420 }
  { 'company': 'IBM',       'size': 400000, 'revenue': 98787 }
  { 'company': 'Skype' ,    'size': 700,    'revenue': 716 }
  { 'company': 'SAP',       'size': 48000,  'revenue': 11567 }
  { 'company': 'Yahoo!',    'size': 14000 , 'revenue': 6426 }
  { 'company': 'eBay',      'size': 15000,  'revenue': 8700 }
]

# Create the labels and the vectors describing the data

labels = new Array()
vectors = new Object()

for i in [0...data.length]
    labels[i] = data[i]['company']
    vectors[i] = 'x': data[i]['size'] , 'y': data[i]['revenue']

k = new KMeans()
k.setPoints vectors
k.guessK()
k.initCentroids()

if k.converged is yes

else
    k.cluster ->
        console.log k.points