---
title: Building Observability Infrastructure
date: '2024-05-15'
description: Log processing with ClickHouse and building evenscribe-collector.
---

# Building Observability Infrastructure

Logs are critical for debugging production systems, but ingesting and processing them at scale presents real engineering challenges. I worked on `evenscribe-collector`, which ingests logs, processes them, and forwards them to ClickHouse for storage and analysis.

Ingestion needs to handle bursts of traffic gracefully. When applications generate logs rapidly, the collector can't just drop them or crash. Buffering is necessary, but infinite buffers run out of memory. I used a bounded buffer that drops old logs when full - better to lose old data than to crash and lose everything. Rate limiting prevents a single source from overwhelming the system.

Processing involves parsing log lines into structured data. Different applications log in different formats - JSON, plain text, custom formats. The collector uses pluggable parsers that extract fields like timestamp, level, message, and metadata. Parsers run in worker threads to parallelize the work.

Batching improves throughput. Instead of writing each log line individually, the collector batches multiple lines and sends them to ClickHouse together. This reduces network round trips and allows ClickHouse to insert more efficiently. Compression on the wire reduces bandwidth usage.

ClickHouse's columnar storage is well-suited for log data. Queries that filter by time range or analyze specific fields are fast because the engine only reads the columns it needs. Aggregations over millions of rows complete in seconds. The compression is significant - log data typically compresses 10x or more.

Schema evolution is a real consideration. Applications add new fields to their logs over time. ClickHouse's flexible schema allows adding columns dynamically, but queries need to handle missing columns gracefully. The collector needs to be resilient to format changes.

Building production infrastructure is different from personal projects. Reliability and observability matter more than clever features. When the collector goes down, you lose visibility into production issues. Monitoring and alerting are as important as the code itself.
