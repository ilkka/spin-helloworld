FROM scratch AS build
WORKDIR /home/ilkka/code/wasm-backend-stuff/spin-helloworld
COPY . .

FROM scratch
COPY --from=build /home/ilkka/code/wasm-backend-stuff/spin-helloworld/spin.toml .
COPY --from=build /home/ilkka/code/wasm-backend-stuff/spin-helloworld/target/wasm32-wasi/release/spin_helloworld.wasm ./target/wasm32-wasi/release/spin_helloworld.wasm
