
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

print "download netflix_mm and netflix_mme first"
train_data_file = "netflix_mm"
test_data_file = "netflix_mme"

#netflix_mm and netflix_mme look like
'''
1 1  3
2 1  5
3 1  4
5 1  3
6 1  3
7 1  4
8 1  3
'''

m = 480189
n = 17770
nnz_train = 99072112
nnz_test = 1408395


# In[3]:

print "prepare test data"
#1-based to 0-based
test_j,test_i,test_rating = np.loadtxt(test_data_file,dtype=np.int32, unpack=True)
print test_j, test_i, test_rating
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
train_j,train_i,train_rating = np.loadtxt(train_data_file,dtype=np.int32, unpack=True)
print train_j, train_i, train_rating
R_train_coo = coo_matrix((train_rating,(train_i - 1,train_j - 1)))


# In[6]:

#for training data, we need COO format to calculate training RMSE
#we need CSR format R when calculate X from \Theta
#we need CSC format of R when calculating \Theta from X
assert R_train_coo.nnz == nnz_train
R_train_coo.row.tofile('R_train_coo.row.bin')


# In[7]:

R_train_csr = R_train_coo.tocsr()
R_train_csc = R_train_coo.tocsc()
R_train_csr.data.astype(np.float32).tofile('R_train_csr.data.bin')
R_train_csr.indices.tofile('R_train_csr.indices.bin')
R_train_csr.indptr.tofile('R_train_csr.indptr.bin')
R_train_csc.data.astype(np.float32).tofile('R_train_csc.data.bin')
R_train_csc.indices.tofile('R_train_csc.indices.bin')
R_train_csc.indptr.tofile('R_train_csc.indptr.bin')

