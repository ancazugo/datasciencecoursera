# Weightlifting Prediction Analysis Using PCA and Random Forests
This is the Practical Machine Learning Project Repository.
If you want a web-based version of the project go to [this RPubs page](https://rpubs.com/ancazugo/weightliftingprediction).
The basic outline of my solution is:
1. Clean the training and testing datasets
   * Remove non-relevant variables
   * Remove variables with more than 95% NAs
2. Do a **Principal Component Analysis (PCA)** on the clean training dataset in order to reduce the number of variables
3. Select the *PCs* whose cumulative proportion of explained variance equals 95%
4. Predcit the new *PCs* on the training dataset
5. Use the predictions to build a **Random Forest** model (parallelization is required)
6. Do a confusion matrix to assess the performance on the training dataset
7. Predict the class outcome on the testing set, first calculating the *PCs* and then using the *Random Forest* model
