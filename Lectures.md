---
layout: page
title: Lectures
order: 2
editor: Jiaming Mao
toc:
- Introduction
- Part I
- Foundations of Statistical Learning
- Regression
- The Truth about P-values
- Classification and Discrete Choice Models
- Model Selection and Regularization
- Decision Trees and Ensemble Methods
- Support Vector Machines
- Neural Networks
- Part II
- Foundations of Causal Inference
---

<p style="height: 1px"></p>

<a id="introduction" />

Introduction ([slides]({{ site.baseurl }}/assets/Lectures/Data_Analysis_for_Economics_-_Introduction.pdf)) [[video](https://www.youtube.com/watch?v=EFbEO3CUD9c&list=PLazlcI8_-ZkMIWIxCSu_HbbNn3L16FYhL&index=2)]
- *Topics:* regression; classification; supervised vs. unsupervised learning; parametric vs. nonparametric models; bias-variance tradeoff; causal inference; treatment effect; randomized experiment; self-selection bias; causal diagram; structural estimation; counterfactual simulation

---

<a id="part-I" />

## Part I

<a id="foundations-of-statistical-learning" />

Foundations of Statistical Learning ([slides]({{ site.baseurl }}/assets/Lectures/Foundations_of_Statistical_Learning.pdf)) [[video](https://www.youtube.com/watch?v=COFGj01aDCw&list=PLazlcI8_-ZkMIWIxCSu_HbbNn3L16FYhL&index=5)]
- *Topics:* learning theory; VC analysis; approximation-generalization tradeoff; bias-variance tradeoff; information theory; KL divergence; cross entropy; maximum likelihood; decision theory; bayes classifier; regression function; discriminative vs. generative model; scientific model
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/blob/master/Materials/Foundations%20of%20Statistical%20Learning/notes%20and%20resources.md)

---

<a id="regression" />

Regression ([slides]({{ site.baseurl }}/assets/Lectures/Regression.pdf)) [[video](https://www.youtube.com/watch?v=-I882DMYbss&list=PLazlcI8_-ZkMIWIxCSu_HbbNn3L16FYhL&index=9)]
- *Topics:* linear regression; hypothesis testing; bootstrap; linear basis expansion; polynomial regression; piecewise constant regression; regression splines; generalized additive model
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/blob/master/Materials/Regression/notes%20and%20resources.md)
- `codes`: [`R`](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Regression/codes/R)

---

<a id="the-truth-about-p-values" />

The Truth about P-values ([slides]({{ site.baseurl }}/assets/Lectures/The_Truth_about_P-values.pdf)) [[video](https://www.youtube.com/watch?v=engy9fb8KRo&list=PLazlcI8_-ZkMIWIxCSu_HbbNn3L16FYhL&index=12)]
- *Topics:* p-values; multiple testing; Bonferroni correction; publication bias; p-hacking; data-snooping
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/blob/master/Materials/The%20Truth%20about%20P-values/notes%20and%20resources.md)

---

<a id="classification-and-discrete-choice-models" />

Classification and Discrete Choice Models ([slides]({{ site.baseurl }}/assets/Lectures/Classification_and_Discrete_Choice_Models.pdf)) [[video](https://www.youtube.com/watch?v=32SB84Vl9mE&list=PLazlcI8_-ZkMIWIxCSu_HbbNn3L16FYhL&index=14)]
- *Topics:* binary and multiclass classification; generalized linear models; logistic regression; similarity-based methods; K-nearest neighbors (KNN); ROC curve; discrete choice models; random utility framework; probit; conditional logit; independence of irrelevant alternatives (IIA)
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Classification%20and%20Discrete%20Choice%20Models/notes%20and%20resources.md)
- `codes`: [`R`](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Classification%20and%20Discrete%20Choice%20Models/codes/R)

---

<a id="model-selection-and-regularization" />

Model Selection and Regularization ([slides]({{ site.baseurl }}/assets/Lectures/Model_Selection_and_Regularization.pdf)) [[video](https://www.youtube.com/watch?v=RXFSqrzbRIg&list=PLazlcI8_-ZkMIWIxCSu_HbbNn3L16FYhL&index=19)]
- *Topics:* cross validation; information criteria; forward stepwise regression; regularization; ridge regression; lasso; elastic net; selective inference; smoothing splines
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/blob/master/Materials/Model%20Selection%20and%20Regularization/notes%20and%20resources.md)
- `codes`: [`R`](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Model%20Selection%20and%20Regularization/codes/R)

---

<a id="decision-trees-and-ensemble-learning" />

Decision Trees and Ensemble Methods ([slides]({{ site.baseurl }}/assets/Lectures/Decision_Trees_and_Ensemble_Methods.pdf))
- *Topics:* decision trees; ensemble learning; bagging; random forest; boosting
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Decision%20Trees%20and%20Ensemble%20Methods/notes%20and%20resources.md)
- `codes`: [`R`](https://github.com/jiamingmao/data-analysis/tree/master/codes/Decision%20Trees%20and%20Ensemble%20Methods/R)

---

<a id="support-vector-machines" />

Support Vector Machines ([slides]({{ site.baseurl }}/assets/Lectures/Support_Vector_Machines.pdf))
- *Topics:* support vector machines; support vector regression
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Neural%20Networks/notes%20and%20resources.md)
- `codes`: [`R`](https://github.com/jiamingmao/data-analysis/tree/master/codes/Neural%20Networks/R)

---

<a id="neural-networks" />

Neural Networks ([slides]({{ site.baseurl }}/assets/Lectures/Neural_Networks.pdf))
- *Topics:* the multilayer perceptron; neural network; deep learning
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/tree/master/Materials/Neural%20Networks/notes%20and%20resources.md)
- `codes`: [`R`](https://github.com/jiamingmao/data-analysis/tree/master/codes/Neural%20Networks/R)

---

<a id="part-II" />

## Part II

<a id="foundations-of-causal-inference" />

Foundations of Causal Inference ([slides]({{ site.baseurl }}/assets/Lectures/Foundations_of_Causal_Inference.pdf))
- *Topics:* causal effect and causal mechanism learning; identification and estimation; discriminative vs. generative causal inference; Rubin causal model; potential outcomes framework; average treatment effect; randomized controlled trials (RCT); exchangeability; self-selection bias; sample-selection bias; internal and external validity; SUTVA; Bayesian belief network; causal graphical model; endogeneity and exogeneity; do-calculus; reduced-form analysis; back-door and front-door criterion; structural estimation; dynamic structural model; counterfactual simulation
- *Notes and resources:* [link](https://github.com/jiamingmao/data-analysis/blob/master/Materials/Foundations%20of%20Causal%20Inference/notes%20and%20resources.md)
