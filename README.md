# st-outlet-exporter

st-outlet-exporter is a [Prometheus](https://prometheus.io/) exporter that monitors power consumption (in W) measured by [Samsung SmartThings compatible smart outlets](https://www.smartthings.com/products/-/filter/categories/outlets).

## How to run

- Get your Samsung SmartThings personal token by visting [this link](https://account.smartthings.com/tokens/new).
- Then, run the exporter like this:

```bash
docker run -it \
           -p 9596:80 \
           -e "SMARTTHINGS_TOKEN=your-token"
           -e "SMARTTHINGS_OUTLET_NAME=Office Outlet"
           stewartpark/st-outlet-exporter
```
