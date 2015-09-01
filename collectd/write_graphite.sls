{% from "collectd/map.jinja" import collectd with context %}

include:
  - collectd.service

{{ collectd.plugindirconfig }}/write_graphite.conf:
  file.managed:
    - source: salt://collectd/files/write_graphite.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: collectd-service
    - defaults:
        graphite_host: {{ salt['pillar.get']('collectd:plugins:write_graphite:host') }}
        graphite_port: {{ salt['pillar.get']('collectd:plugins:write_graphite:port', '2003') }}
