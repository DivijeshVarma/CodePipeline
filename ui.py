import streamlit as st
import os
from langchain_cohere import ChatCohere

# Title of the Streamlit app
st.title("Divijesh Bot Main - v2")

# Initialize chat history in session state if not already present
if "messages" not in st.session_state:
    st.session_state.messages = []

# Display chat messages from history on app rerun
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

# Initialize LLM with Cohere (API key should ideally be set via environment variable)
cohere_api_key = os.getenv("COHERE_API_KEY", "your-default-api-key-here")  # Using an environment variable
llm = ChatCohere(model="command-r-plus", cohere_api_key=cohere_api_key, temperature=0)

# Accept user input
if prompt := st.chat_input("Enter your question"):
    # Add user message to chat history
    st.session_state.messages.append({"role": "user", "content": prompt})
    
    # Display user message in chat message container
    with st.chat_message("user"):
        st.markdown(prompt)

    # Display assistant's response in the chat message container
    with st.chat_message("assistant"):
        # Stream the response from LLM
        response = ""
        for chunk in llm.stream(prompt):  # Assuming llm.stream() yields chunks of text
            response += chunk
            st.write(response)  # Display streaming response incrementally

    # Append assistant's final response to the message history
    st.session_state.messages.append({"role": "assistant", "content": response})


