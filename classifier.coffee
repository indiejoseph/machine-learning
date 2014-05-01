###
Support Vector Model
###

nodesvm = require 'node-svm'

xorProblem = [
  [[0,0], 1]
  [[1,1], 1]
  [[0,1], -1]
  [[1,0], -1]
]

svm = new nodesvm.CSVC(
    kernel: nodesvm.KernelTypes.RBF
    C: 1.0
    gamma: 0,5
)

svm.once 'trained', (report)  ->
    console.log '''

    --------------------
    Support Vector Model
    --------------------
    '''
    # 'report' provides information about svm's accuracy
    [0,1].forEach (a) ->
        [0,1].forEach (b) ->
            prediction = svm.predict [a, b]
            console.log "%d XOR %d => %d", a, b, prediction

svm.train xorProblem


###
Naive-Bayes classifier
###
console.log '''

--------------------
Naive-Bayes classifier
--------------------
'''

bayes = require 'bayes'
classifier = bayes()

classifier.learn('amazing, awesome movie!! Yeah!! Oh boy.', 'positive')
classifier.learn('Sweet, this is incredibly, amazing, perfect, great!!', 'positive')

# teach it a negative phrase

classifier.learn('terrible, shitty thing. Damn. Sucks!!', 'negative')

# now ask it to categorize a document it has never seen before

label = classifier.categorize('awesome, cool, amazing!! Yay.')

console.log '`awesome, cool, amazing` = %s', label


###
K-means
###

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

kmeans = require 'node-kmeans'
labels = new Array()
vectors = new Array()

for i in [0...data.length]
    vectors[i] = [ data[i]['size'] , data[i]['revenue'] ]

kmeans.clusterize vectors, {k: 4}, (err,res) ->

    console.log '''

    -------------------
    K-means
    -------------------
    '''

    if err
        console.error err
    else
        for r in res
            companies = []
            for c in r.clusterInd
                companies.push data[c].company
            console.log companies


###
K-Nearest Neighbour
###

console.log '''

-------------------
K-Nearest Neighbour
-------------------
'''

knn = require 'alike'

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

options =
    k: 2,
    weights:
        size: 0.3
        revenue: 0.7

my_company =
    size: 3
    revenue: 10

c = knn my_company, data, options

console.log c
