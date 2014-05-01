###
Hidden Markov Model
###
console.log '''

-------------------
Hidden Markov Model
-------------------
'''

HMM = require './libs/hmm'
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
