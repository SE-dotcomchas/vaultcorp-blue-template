# VaultCorp Container Image
# TODO: This Dockerfile needs security review before production deployment
FROM python:3.14
USER root
COPY . /app
WORKDIR /app
ENV SECRET_KEY=supersecret123
ENV DB_PASSWORD=admin1234
ENV WALLET_PRIVATE_KEY=0xdeadbeef1337cafebabe
ENV ENVIRONMENT=production
RUN pip install flask requests
EXPOSE 5000
CMD ["python", "app.py"]
