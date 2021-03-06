#include "cvm.h"

Buffer::Buffer()
{
}

Buffer::Buffer(const Buffer &other)
{
    this->length = other.length;
    if (other.data)
    {
        this->data = (byte *)malloc(this->length);
        memcpy(this->data, other.data, this->length);
    }
}

Buffer::~Buffer()
{
    delete[] this->data;
}

Buffer &Buffer::operator=(const Buffer &other)
{
    delete[] this->data;
    this->length = other.length;
    if (other.data)
    {
        this->data = (byte *)malloc(this->length);
        memcpy(this->data, other.data, this->length);
    }
    return *this;
}

void Buffer::resize(size_t new_length)
{
    byte *new_data = (byte *)malloc(new_length);
    if (data)
    {
        memcpy(new_data, this->data, min(this->length, new_length));
    }
    delete[] this->data;
    this->data   = new_data;
    this->length = new_length;
}

void Buffer::append(const byte *data, size_t data_length)
{
    const size_t old_length = this->length;
    const size_t new_length = old_length + data_length;
    assert(new_length > old_length);
    resize(new_length);
    memcpy(this->data + old_length, data, data_length);
}
