
# coding: utf-8

# In[1]:

# assume input is given in text format
# each line is like 
# "user_id item_id rating"

import os
from six.moves import urllib
import numpy as np
from scipy.sparse import csr_matrix
from scipy.sparse import csc_matrix
from scipy.sparse import coo_matrix
from scipy import sparse


# In[2]:

print "download jester_train.csv and dont_use.csv first"
train_data_file = "jester_train.csv"
test_data_file = "dont_use.csv"

#jester files look like
'''
7302,29,7.156
61815,46,6.375
31128,96,2.281
36125,147,-1.781
18007,60,2.188
7387,99,3.594
12007,18,-2.094
'''

m = 63978
n = 150
nnz_train = 1000000
nnz_test = 761439


# In[3]:

print "prepare test data"
#1-based to 0-based
test_i,test_j,test_rating = np.loadtxt(test_data_file, delimiter=',', dtype=[('f0', np.int32),('f1',np.int32),('f2',np.float)], skiprows=1, unpack=True)
print test_i, test_j, test_rating
R_test_coo = coo_matrix((test_rating,(test_i - 1,test_j - 1)))


# In[4]:

#for test data, we need COO format to calculate test RMSE
assert R_test_coo.nnz == nnz_test
R_test_coo.data.astype(np.float32).tofile('R_test_coo.data.bin')
R_test_coo.row.tofile('R_test_coo.row.bin')
R_test_coo.col.tofile('R_test_coo.col.bin')


# In[5]:

print "prepare training data"
#1-based to 0-based
train_i,train_j,train_rating = np.loadtxt(train_data_file, delimiter=',', dtype=[('f0', np.int32),('f1',np.int32),('f2',np.float)], skiprows=1, unpack=True)
print train_i, train_j, train_rating
R_train_coo = coo_matrix((train_rating,(train_i - 1,train_j - 1)))


# In[6]:

#for training data, we need COO format to calculate training RMSE
#we need CSR format R when calculate X from \Theta
#we need CSC format of R when calculating \Theta from X
print R_train_coo.nnz, nnz_train
assert R_train_coo.nnz == nnz_train
R_train_coo.row.tofile('R_train_coo.row.bin')
R_train_coo.col.tofile('R_train_coo.col.bin')
R_train_coo.data.tofile('R_train_coo.data.bin')

# In[7]:

R_train_csr = R_train_coo.tocsr()
R_train_csc = R_train_coo.tocsc()
R_train_csr.data.astype(np.float32).tofile('R_train_csr.data.bin')
R_train_csr.indices.tofile('R_train_csr.indices.bin')
R_train_csr.indptr.tofile('R_train_csr.indptr.bin')
R_train_csc.data.astype(np.float32).tofile('R_train_csc.data.bin')
R_train_csc.indices.tofile('R_train_csc.indices.bin')
R_train_csc.indptr.tofile('R_train_csc.indptr.bin')

