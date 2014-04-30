// n: number of inner nodes, a: alphabet

MIN_FLOAT = -3.14e100

function initArray(length, value) {
    var arr = [], i = 0;
    arr.length = length;
    while (i < length) { arr[i++] = value; }
    return arr;
}

function log(value) {
    if(value == 0)
        value = MIN_FLOAT
    else
        value = Math.log(value)
    return value
}

function HMM(nStates, nObs) {
    /*
    HMM constructor.

    Parameters
    ----------
    nStates: non-negative integer
        Number of hidden states.
    nObs: non-negative integer
        Number of possible observed values.
    */

    this.nStates = nStates
    this.nObs = nObs
    this.t = []
    this.e = []
    this.pi = initArray(nStates, 0)

    for(var i = 0; i < nStates; i++) {
        this.t.push(initArray(nStates, 0))
        this.e.push(initArray(nObs, 0))
    }
};

HMM.prototype.learn = function(observations, ground_truths) {
    /*Learns from a list of observation sequences and their associated ground truth.

    Parameters
    ----------
    observations: list of list of integers in {0, ..., nObs-1}
        List of observed sequences.
    ground_truths: list of list of integers in {0, ..., nStates-1}
        Associated list of ground truths.*/

    if(observations.length != ground_truths.length) {
        throw new Error('observations and ground_truths length do not match');
    }

    obs_len = observations.length;
    for(var i = 0; i < obs_len; i++) {
        var o = observations[i];
        var t = ground_truths[i];
        if(o.length != t.length) {
            throw new Error('observations and ground_truths length do not match');
        }

        this.pi[t[0]]++;
        for(var j = 0; j < (t.length-1); j++) {
            this.t[t[j]][t[j+1]]++;
            this.e[t[j]][o[j]]++;
        }
        this.e[t[j]][o[j]]++;
    }

    for(var i = 0; i < this.nStates; i++) {
        this.pi[i] /= obs_len;
        var add = function(a,b){return a+b};
        var Zt=this.t[i].reduce(add, 0);
        var Ze=this.e[i].reduce(add, 0);
        for(var j = 0; j < this.nStates; j++)
            this.t[i][j] /= Math.max(1, Zt);
        for(var j = 0; j < this.nObs; j++)
            this.e[i][j] /= Math.max(1, Ze);
    }
};

// Viterbi algorithm for finding hidden relationships
HMM.prototype.viterbi = function(observations) {
    var V = [{}];
    var path = {};

    // Initialize base cases (t == 0)
    for(var i = 0; i < this.nStates; i++) {
        V[0][i] = log(this.pi[i]) + log(this.e[i][observations[0]]);
        path[i] = [i];
    }

    // Run Viterbi for t > 0
    for(var t = 1; t < observations.length; t++) {
        V.push({});
        var newpath = {};

        for(var i = 0; i < this.nStates; i++) {
            var max = [MIN_FLOAT, null];
            for(var j = 0; j < this.nStates; j++) {
                // Calculate the probablity
                var t_p = log(this.t[j][i])
                var e_p = MIN_FLOAT
                if(observations[t] < this.e[i].length)
                    e_p = log(this.e[i][observations[t]])
                var calc = V[t-1][j] + t_p + e_p;

                if(calc > max[0] || max[1] == null) max = [calc, j];
            }
            V[t][i] = max[0];
            newpath[i] = path[max[1]].concat(i);
        }
        path = newpath;
    }

    var max = [MIN_FLOAT, null];
    for(var i = 0; i < this.nStates; i++) {
        var calc = V[observations.length - 1][i];
        if(calc > max[0]) max = [calc, i];
    }

    return [max[0], path[max[1]]];
}

states = [
    'Rainy',
    'Sunny'
];
observations = [
    'walk',
    'shop',
    'clean'
];

hmm = new HMM(states.length, observations.length);
train = [
    [
        [0, 1, 2]
    ],
    [
        [1, 0, 0]
    ]
];
hmm.learn(train[0], train[1]);
// hmm.t = [
//     [0.7, 0.3],
//     [0.4, 0.6]
// ]
// hmm.e = [
//     [0.1, 0.4, 0.5],
//     [0.6, 0.3, 0.1]
// ]
// hmm.pi = [0.6, 0.4]

results = (hmm.viterbi([0, 1, 2]));

console.log(results);
for(var i = 0; i < results[1].length; i++) {
    var state = results[1][i];
    console.log(states[state]);
}
