function fish_right_prompt
  set -l k8s_color (set_color red)
  set -l k8s_context (kubectl config current-context)
  set -l k8s_ns (kubectl config view --minify --output 'jsonpath={..namespace}')

  test -n "$k8s_ns"; or set -l k8s_ns default

  echo -e -n -s $k8s_color "($k8s_context:$k8s_ns)"
end
