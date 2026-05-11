<div align="center">
  <h1>
    End-to-End Credit Risk Analytics & Loan Default Prediction System
  </h1>
</div>

<p align="center">
  <img src="https://img.shields.io/badge/SQL-BigQuery%20Advanced%20Analytics-blue?style=flat-square"/>
  <img src="https://img.shields.io/badge/TensorFlow-Deep%20Learning%20Classification-orange?style=flat-square"/>
  <img src="https://img.shields.io/badge/Machine%20Learning-Default%20Prediction-success?style=flat-square"/>
  <img src="https://img.shields.io/badge/BI-Executive%20Risk%20Dashboard-purple?style=flat-square"/>
</p>

---

## 🧠 Business Problem

In the fintech lending industry, accurately assessing credit risk is critical to portfolio health and profitability. Approving high-risk borrowers leads to charge-offs and financial loss, while over-rejecting creditworthy applicants leaves revenue on the table. Many lenders rely on outdated rule-based underwriting that misclassifies applicants and creates bottlenecks in the decision pipeline. This project addresses the need for a data-driven, automated credit risk system that predicts loan default probability at the point of application.

---

## 🎯 Objective

The ultimate goal was to enable the lending company to proactively identify high-risk applicants and automate underwriting decisions. The objective of this project was to:

- Analyze historical borrower and loan data to understand the key drivers of default
- Design a relational data model capturing the full lending lifecycle
- Build a deep learning classification model to estimate default probability per applicant
- Generate SQL-based analytics for portfolio risk segmentation and cohort performance
- Design an executive-level credit risk dashboard to support underwriting decisions

---

## 📊 Data & Inputs

The project utilized synthetic relational lending data modeled into normalized tables:

- **Borrowers** — demographics, credit score, state
- **Employment Details** — income, employment type and tenure
- **Loan Applications** — requested amount, purpose, status
- **Loans** — approved loan terms, interest rate, default flag
- **Credit History** — account types, late payments, derogatory marks
- **Payments** — monthly payment records and delinquency status
- **Risk Predictions** — model output scores, risk class, decision recommendations

---

## ⚙️ Technical Approach

- Designed a 7-table relational data model capturing the end-to-end lending lifecycle and implemented the ERD schema
- Generated fully relational synthetic datasets with realistic credit risk distributions and probabilistic default labeling
- Performed advanced BigQuery SQL EDA covering default rate by income group, risk segmentation, cohort performance, credit score correlation, DTI impact analysis, and time-based repayment behavior using CTEs, window functions, and aggregations
- Engineered 22+ features from raw borrower, employment, and credit history data including debt-to-income ratio, credit utilization, derogatory rate per account, and monthly payment burden
- Built a TensorFlow deep neural network with batch normalization, residual skip connections, and dropout regularization
- Applied Keras Tuner Bayesian hyperparameter optimization and early stopping with learning rate decay
- Selected the optimal classification threshold using Youden's J statistic on the ROC curve
- Designed an executive credit risk dashboard with KPI cards, risk trend charts, application funnel, and a high-risk applicant review table

---

## 🛠 Key Skills Demonstrated

- End-to-end data science workflow (SQL, Python, Deep Learning, BI Dashboard)
- Relational data modeling and synthetic data generation
- Advanced BigQuery SQL analytics for portfolio risk intelligence
- Feature engineering driven by credit risk domain knowledge
- Deep learning classification with TensorFlow and Keras Tuner
- ROC-AUC optimization and threshold calibration for imbalanced classification
- Executive dashboard design aligned with credit risk KPIs
- Translating model outputs into actionable underwriting decisions

---

## 🎥 YouTube Walkthrough
