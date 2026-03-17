# Supply Chain Delivery Performance & Delay Impact Analysis

---

##  Background & Business Context

The Operations leadership team identified a growing volume of customer complaints related to late deliveries. While delays were being tracked operationally, there was limited visibility into:

- The true scale of delivery delays  
- The financial impact of those delays  
- Whether delays were driven by specific regions, products, or operational processes  

As part of this analysis, I was tasked with identifying the key drivers of delivery delays and providing actionable recommendations to improve shipping performance.

---

##  Business Objectives

This analysis was conducted to answer the following key business questions:

- What percentage of orders are delivered late?
- What portion of revenue and profit is impacted by delays?
- Are delays concentrated in specific regions or product categories?
- Do delays follow seasonal or time-based trends?
- What operational factors are driving delays?
- Where should improvements be prioritized?

---

##  Data Structure Overview

The dataset contains approximately **180,000 supply chain transactions**, with each row representing a unique order.

### Key Fields

**Shipping & Delivery**
- Days for shipping (real)
- Days for shipment (scheduled)
- Delivery Status
- Shipping Mode

**Order & Customer**
- Order Region
- Customer Segment
- Order Date

**Product**
- Category Name
- Product Price
- Order Item Quantity

**Financials**
- Sales
- Order Profit Per Order

---

##  Data Cleaning & Feature Engineering

To ensure accurate analysis, several transformations and derived metrics were created:

### 1. Standardization
- Renamed columns for consistency
- Converted date fields into proper datetime format

### 2. Derived Metrics
- delay_days = actual_shipping_days - scheduled_shipping_days

- **late_delivery_flag** captures any delay (including minor 1-day delays)
- **material_delay_flag** isolates meaningful operational delays (2+ days)

### 3. Business Segmentation
- Created `order_value_segment` (Low / Medium / High)
- Extracted time-based features (month, weekday)

---

## ⚠️ Data Quality Issue & Adjustment

A significant anomaly was identified during analysis:

- All **First Class shipments (~27,000 orders)** were recorded as exactly **1 day late**
- This resulted in a **100% delay rate** for this shipping mode

This pattern strongly suggests a **systematic data or labeling issue**, rather than a true operational problem.

### Adjustment Approach

To ensure accurate insights:

- Introduced **material_delay_flag (≥ 2 days)** to isolate true operational delays  
- Retained overall delay metrics for completeness, but prioritized material delays for decision-making  

This ensured that conclusions were based on **real performance issues rather than data artifacts**

---

##  Executive Summary

- **57% of all orders are marked as late**
- However, only **24% of orders experience material delays (≥ 2 days)**
- Late deliveries impact approximately:
  - **$21.03M in revenue**
  - **$2.23M in profit**

### Key Takeaways

- A large portion of delays are minor (1-day), but a significant subset represents true operational inefficiencies  
- Delay rates are **consistent over time**, indicating no seasonal driver  
- Delays are **distributed across all regions**, suggesting systemic issues  
- Certain product categories show elevated delay rates, indicating localized operational challenges  

---

##  Insights Deep Dive

### 1. Delay Prevalence & Severity

- **Overall delay rate:** 57%  
- **Material delay rate (2+ days):** 24%  

This indicates that while delays are widespread, **less than half represent meaningful operational failures**

---

### 2. Financial Impact

- **$21.03M in revenue** is associated with late deliveries  
- **$2.23M in profit** is tied to delayed orders  

This confirms that delivery delays are not just operational issues — they represent a **material financial risk**

---

### 3. Product Category Performance

Certain categories consistently exhibit higher delay rates:

- Soccer-related products  
- Golf-related products  
- Apparel segments  

These categories likely involve:
- More complex inventory handling  
- Supplier variability  
- Longer fulfillment times  

---

### 4. Regional Analysis

- Delay rates are relatively uniform across regions (~55–59%)  
- High-volume regions contribute the majority of delayed orders and financial impact  

This indicates that delays are **not region-specific**, but rather driven by **system-wide operational processes**

---

### 5. Time Trend Analysis

- Delay rates remain stable across months and years  
- No significant seasonal spikes were observed  

This suggests that delays are driven by **persistent operational inefficiencies**, not demand fluctuations

---

### 6. Operational Drivers (Modeling Insight)

A Random Forest Classification machine learning model was used to identify key drivers of delays.

**Result:**
- No strong or dominant predictive features were identified beyond basic shipping time variables  

**Interpretation:**
- Delays are not driven by specific factors such as region, product, or customer segment  
- Instead, they reflect **broad, systemic inefficiencies across the supply chain**

This reinforces the conclusion that improvements must focus on **overall process optimization rather than isolated fixes**

---

##  Recommendations

### 1. Simplify Shipping Options

Current shipping modes show inconsistencies and limited differentiation:

- First Class data is unreliable (systematic 1-day delay issue)  
- Second Class performs similarly to Standard  
- Same Day provides clear value but is limited  

### Recommendation:
Transition to a simplified model:

- **Same Day (premium option)**  
- **Standard (default option)**  

**Rationale:**
- Reduces operational complexity  
- Improves consistency in delivery expectations  
- Eliminates confusion caused by poorly differentiated shipping tiers  
- Aligns logistics resources more effectively  

---

### 2. Evaluate Staffing and Operational Capacity

Given that delays are consistent across regions and time periods, and no specific driver was identified in modeling, this suggests that delays may be partially driven by **capacity constraints within fulfillment operations**.

While the data does not directly include staffing levels, the following indicators support this hypothesis:

- Persistent delay rates (~57%) regardless of seasonality  
- No strong predictive drivers identified in modeling  
- Uniform performance across regions, indicating system-wide constraints  

### Recommendation:

Conduct an operational review of staffing and throughput capacity across warehouses and fulfillment centers, including:

- Order volume vs. staffing levels  
- Peak-hour processing capacity  
- Warehouse throughput efficiency  

If capacity constraints are confirmed:

- Increase staffing during peak operational hours  
- Reallocate labor to high-volume fulfillment centers  
- Evaluate automation opportunities to improve throughput  

**Rationale:**

Improving staffing alignment with demand can reduce bottlenecks in order processing and shipping, leading to a reduction in material delays and improved delivery performance.

### 3. Prioritize High-Impact Regions

- Focus improvements in regions with the highest revenue and order volume  
- Optimize distribution networks and shipping routes  

---

### 4. Improve Data Quality & Tracking

- Address inconsistencies in shipping mode reporting  
- Refine SLAs and tracking systems to ensure accurate performance measurement  

---

### 5. Implement Continuous Monitoring

- Deploy dashboards tracking:
  - Delay rates  
  - Revenue impact  
  - Category performance  

This enables proactive management of delivery performance

---

### 6. Implement Continuous Monitoring

- Deploy dashboards tracking:
  - Delay rates  
  - Revenue impact  
  - Category performance  

This enables proactive management of delivery performance

--
