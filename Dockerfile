FROM --platform=${BUILDPLATFORM} rust:1.69 AS build
ARG SPIN_VERSION=v1.1.0
WORKDIR /work

RUN rustup target add wasm32-wasi
RUN rustup target add wasm32-unknown-unknown
RUN curl -fsSL https://developer.fermyon.com/downloads/install.sh | bash -s -- -v ${SPIN_VERSION} && mv ./spin /bin

COPY Cargo.lock Cargo.toml ./
RUN mkdir src \
	&& echo "fn main() {print!(\"Dummy main\");} // dummy file" > src/lib.rs \
	&& cargo build --locked --target wasm32-wasi --release \
	&& rm -f ./target/wasm32-wasi/release/*.wasm ./src/lib.rs

COPY . ./
RUN spin build

FROM scratch
WORKDIR /
COPY --from=build /work/target/wasm32-wasi/release/spin_helloworld.wasm ./target/wasm32-wasi/release/
COPY --from=build /work/spin.toml .
