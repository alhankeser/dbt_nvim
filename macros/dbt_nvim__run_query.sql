{% macro dbt_nvim__run_query(sql) %}
    {% set result = run_query(sql) %}
    {% set columns = result.column_names %}
    {% set data = [] %}
    {% for row in result.rows %}
        {% set row_values = [] %}
        {% for i in range(0, columns | length) %}
            {% if row[i] is number %}
                {% set value = row[i] | float %}
            {% else %}
                {% set value = row[i] | string %}
            {% endif %}
            {% set row_values = row_values.append(value) %}
        {% endfor %}
        {% set data = data.append(row_values) %}
    {% endfor %}
    {% set result_json = {'columns': columns, 'data': data} %}
    {% do print(result_json | tojson) %}
{% endmacro %}

