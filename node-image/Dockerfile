FROM kindest/node:v1.26.3

RUN curl -fsSL https://github.com/deislabs/containerd-wasm-shims/releases/download/v0.5.1/containerd-wasm-shims-v1-linux-x86_64.tar.gz | tar xvz -C /bin \
	&& chmod +x /bin/containerd-shim-*-v1
RUN echo '\n[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.spin]\nruntime_type = "io.containerd.spin.v1"\n' >>/etc/containerd/config.toml
