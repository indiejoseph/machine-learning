###
Chi Square Test
###

console.log '''

-------------------
Chi Square Test
-------------------
'''
sd = require './libs/statistics-distributions'
# |             |  Asia | Africa | South America | Totals |
# |-------------|-------|--------|---------------|--------|
# | Malaria A   | 31    | 14     | 45            | 90     |
# | Malaria B   | 2     | 5      | 53            | 60     |
# | Malaria C   | 53    | 45     | 2             | 100    |
# |-------------|-------|--------|---------------|--------|
# | Total       | 86    | 64     | 100           | 250    |

# data = [[31, 14, 45],
#         [2,  5,  53],
#         [53, 45, 2]]
# cv = 0
# n  = 0
# dof = (data.length - 1) * (data[0].length - 1)

# for i in [0...data.length]
#     n += data[i].reduce (t, s) -> t + s

# for i in [0...data.length]
#     rsum = data[i].reduce (t, s) -> t + s
#     for j in [0...data[i].length]
#         csum = 0
#         for k in [0...data.length]
#             csum += data[k][j]
#         expected = rsum * csum / n
#         cv += Math.pow(data[i][j] - expected, 2) / expected

# |              | No Heart Rate | Heart Rate Increased | Total |
# |--------------|---------------|----------------------|-------|
# | Treated      | 36            |14                    | 50    |
# | Not treated  | 30            |25                    | 55    |
# |--------------|---------------|----------------------|-------|
# | Total        | 66            |39                    | 105   |

a = 36
b = 14
c = 30
d = 25
dof = 1
n = a+b+c+d
cv = (n * Math.pow((a*d)-(b*c), 2)) / ((a+b)*(c+d)*(a+c)*(b+d))
console.log 'Crtical Value: %d', cv
chi = sd.chisqrprob(dof, cv)
console.log 'Probability: p = %d, p < 0.05 as a significant difference', chi

